# Project time logging

This example looks up a user in your Xero organisation, then creates a project for a contact, adds a chargeable task to it, logs time against the task and reads the time entries back.

## Prerequisites

### 1. Set up a Xero app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-xero.projects/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret, refresh token and tenant ID. The app needs the `projects`, `projects.read` and `offline_access` scopes.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
contactId = "<xero-contact-id>"
projectName = "<project-name>"
entryDateUtc = "<entry-date, e.g. 2026-10-05T09:00:00Z>"
minutesLogged = 60
confirmCreate = false
```

Creating a project, task and time entry changes data in your organisation, so the example only does so when `confirmCreate` is `true`. Otherwise it prints the user it would log time for and stops.

## Run the example

Execute the following command to run the example:

```bash
bal run
```
