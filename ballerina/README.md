## Overview

[Xero](https://www.xero.com/) is a cloud-based accounting platform for small and medium-sized businesses. Its Projects API lets you track time and costs against client work, and covers projects, the tasks within them, time entries, and the users who can be assigned work.

The Xero Projects connector provides a Ballerina client for version 2.0 of the Xero Projects API. It lets you create and update projects, manage tasks and their charge rates, log and edit time entries, and list the users available for project work from your integrations.

### Key features

- Create, retrieve, update and close projects for your contacts
- Manage project tasks with time-based, fixed or non-chargeable rates
- Log, update and delete time entries and filter them by user, task, date or invoice
- List project users and page through large result sets

## Setup guide

To use the Xero Projects connector, you need a Xero app that can call the Projects API for your organisation.

1. Sign in to the [Xero developer portal](https://developer.xero.com/app/manage) and select **New app**.

2. Enter an app name and company or application URL, choose the **Web app** integration type, and add a redirect URI for your application.

3. Open the **Configuration** page of the app and copy the **Client id**. Generate a **Client secret** and copy it.

4. Run the OAuth 2.0 authorization code flow against `https://login.xero.com/identity/connect/authorize` requesting the `projects`, `projects.read` and `offline_access` scopes. Exchange the returned code at `https://identity.xero.com/connect/token` for an access token and a refresh token.

5. Call `GET https://api.xero.com/connections` with the access token and copy the `tenantId` of the organisation you want to work with. Every operation of the connector takes it as the `xeroTenantId` header.

## Quickstart

To use the `xero.projects` connector in your Ballerina application, update the `.bal` file as follows:

Step 1: Import the connector.

```ballerina
import ballerinax/xero.projects;
```

Step 2: Create a `Config.toml` file with your credentials.

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
tenantId = "<xero-tenant-id>"
```

Step 3: Create a client and read the configuration.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string tenantId = ?;

projects:Client projectsClient = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

Step 4: List the projects of your organisation.

```ballerina
public function main() returns error? {
    projects:ProjectList _ = check projectsClient->listProjects({xeroTenantId: tenantId});
}
```

## Examples

The `Xero Projects` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](../examples/), covering the following use cases:

1. [Project time logging](../examples/project_time_logging/project_time_logging.md) - Create a project for a contact, add a chargeable task, log time against it and read the entries back.

2. [Project progress report](../examples/project_progress_report/project_progress_report.md) - Compare the estimated and logged minutes of every in-progress project.
