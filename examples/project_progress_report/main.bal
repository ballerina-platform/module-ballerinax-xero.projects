import ballerina/io;
import ballerinax/xero.projects;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string tenantId = ?;
configurable int pageSize = 50;

public function main() returns error? {
    projects:Client projectsClient = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: Collect every in-progress project, following the pages until a short page.
    projects:Project[] inProgress = [];
    int page = 1;
    while true {
        projects:ProjectList list = check projectsClient->listProjects({xeroTenantId: tenantId},
            states = "INPROGRESS", page = page, pageSize = pageSize);
        projects:Project[] batch = list.items ?: [];
        inProgress.push(...batch);
        if batch.length() < pageSize {
            break;
        }
        page += 1;
    }
    io:println("In-progress projects: ", inProgress.length());

    // Step 2: For each project compare estimated task minutes with the minutes logged.
    foreach projects:Project project in inProgress {
        string projectId = project.projectId ?: "";
        if projectId == "" {
            continue;
        }
        int estimated = 0;
        int taskPage = 1;
        while true {
            projects:TaskList taskList = check projectsClient->listTasks(projectId, {xeroTenantId: tenantId},
                page = taskPage, pageSize = pageSize);
            projects:Task[] tasks = taskList.items ?: [];
            foreach projects:Task task in tasks {
                estimated += task.estimateMinutes ?: 0;
            }
            if tasks.length() < pageSize {
                break;
            }
            taskPage += 1;
        }
        io:println(project.name, ": ", project.minutesLogged ?: 0, " of ", estimated, " estimated minutes logged");
    }

    // Step 3: List the users that can be assigned work.
    int userCount = 0;
    int userPage = 1;
    while true {
        projects:ProjectUserList userList = check projectsClient->listProjectUsers({xeroTenantId: tenantId},
            page = userPage, pageSize = pageSize);
        projects:ProjectUser[] users = userList.items ?: [];
        userCount += users.length();
        if users.length() < pageSize {
            break;
        }
        userPage += 1;
    }
    io:println("Project users: ", userCount);
}
