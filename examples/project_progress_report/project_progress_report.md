# Project progress report

This example lists every in-progress project in your Xero organisation, page by page, and prints the minutes logged against each project next to the total estimated minutes of its tasks. It only reads data.

## Prerequisites

### 1. Set up a Xero app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.projects/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret, refresh token and tenant ID. The app needs the `projects.read` and `offline_access` scopes.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
pageSize = 50
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
