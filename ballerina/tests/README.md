# Running Tests

## Prerequisites

The tests run against a mock server by default, so no credentials are needed.

To run them against the live Xero Projects API, set:

```bash
export IS_LIVE_SERVER=true
export XERO_ACCESS_TOKEN=<access-token>
export XERO_TENANT_ID=<xero-tenant-id>
export XERO_PROJECT_ID=<project-id>
export XERO_TASK_ID=<task-id>
export XERO_TIME_ENTRY_ID=<time-entry-id>
```

Mutating tests are skipped against the live server, and the read tests use the project, task and time entry IDs given in `XERO_PROJECT_ID`, `XERO_TASK_ID` and `XERO_TIME_ENTRY_ID`, which must exist in the organisation.

## Test scenarios

The suite covers all 16 operations of the client: listing, creating, retrieving, updating, closing and deleting projects, tasks and time entries, and listing project users.

## Running the tests

```bash
bal test
```
