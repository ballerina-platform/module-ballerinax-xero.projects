import ballerina/io;
import ballerinax/xero.projects;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string tenantId = ?;
configurable string contactId = ?;
configurable string projectName = ?;
configurable string entryDateUtc = ?;
configurable int minutesLogged = 60;
configurable boolean confirmCreate = false;

public function main() returns error? {
    projects:Client projectsClient = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: Pick the user who will log the time.
    projects:ProjectUserList users = check projectsClient->listProjectUsers({xeroTenantId: tenantId});
    projects:ProjectUser[] userItems = users.items ?: [];
    if userItems.length() == 0 {
        return error("No project users found in the organisation");
    }
    string userId = userItems[0].userId ?: "";
    if userId == "" {
        return error("The first project user has no user id");
    }
    io:println("Time will be logged for: ", userItems[0].name ?: userId);

    if !confirmCreate {
        io:println("Dry run: set confirmCreate = true to create the project, task and time entry.");
        return;
    }

    // Step 2: Create the project for the contact.
    projects:Project project = check projectsClient->createProject({xeroTenantId: tenantId}, {
        contactId,
        name: projectName
    });
    string projectId = project.projectId ?: "";
    if projectId == "" {
        return error("The created project has no project id");
    }
    io:println("Created project: ", projectId);

    // Step 3: Add a chargeable task to the project.
    projects:Task task = check projectsClient->createTask(projectId, {xeroTenantId: tenantId}, {
        name: "Consulting",
        rate: {currency: "USD", value: 120},
        chargeType: "TIME",
        estimateMinutes: 480
    });
    string taskId = task.taskId ?: "";
    if taskId == "" {
        return error("The created task has no task id");
    }
    io:println("Created task: ", taskId);

    // Step 4: Log time against the task.
    projects:TimeEntry entry = check projectsClient->createTimeEntry(projectId, {xeroTenantId: tenantId}, {
        userId,
        taskId,
        dateUtc: entryDateUtc,
        duration: minutesLogged,
        description: "Initial consulting session"
    });
    io:println("Logged time entry: ", entry.timeEntryId ?: "");

    // Step 5: Read the entries back for the project.
    projects:TimeEntryList entries = check projectsClient->listTimeEntries(projectId, {xeroTenantId: tenantId});
    foreach projects:TimeEntry item in entries.items ?: [] {
        io:println(item.dateUtc ?: "", " ", item.duration ?: 0, " minutes");
    }
}
