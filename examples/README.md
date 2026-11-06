# Examples

The `ballerinax/xero.projects` connector provides practical examples illustrating usage in various scenarios.

1. **[Project time logging](https://github.com/ballerina-platform/module-ballerinax-xero.projects/tree/main/examples/project_time_logging)** - Create a project for a contact, add a chargeable task, log time against it and read the entries back.

2. **[Project progress report](https://github.com/ballerina-platform/module-ballerinax-xero.projects/tree/main/examples/project_progress_report)** - Compare the estimated and logged minutes of every in-progress project.

## Prerequisites

1. Generate Xero credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/xero.projects/latest#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://identity.xero.com/connect/token"
tenantId = "<xero-tenant-id>"
```

Each example lists the additional values it needs in its own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```
