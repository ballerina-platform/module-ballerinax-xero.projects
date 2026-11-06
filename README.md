# Ballerina Xero Projects connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-xero.projects/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.projects/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-xero.projects.svg)](https://github.com/ballerina-platform/module-ballerinax-xero.projects/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/xero.projects.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fxero.projects)

## Overview

[Xero](https://www.xero.com/) is a cloud-based accounting platform for small and medium-sized businesses. Its Projects API lets you track time and costs against client work, and covers projects, the tasks within them, time entries, and the users who can be assigned work.

The Xero Projects connector provides a Ballerina client for version 2.0 of the Xero Projects API. It lets you create and update projects, manage tasks and their charge rates, log and edit time entries, and list the users available for project work from your integrations.

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

The `Xero Projects` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](examples/), covering the following use cases:

1. [Project time logging](examples/project_time_logging/project_time_logging.md) - Create a project for a contact, add a chargeable task, log time against it and read the entries back.

2. [Project progress report](examples/project_progress_report/project_progress_report.md) - Compare the estimated and logged minutes of every in-progress project.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`xero.projects` package](https://central.ballerina.io/ballerinax/xero.projects/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
