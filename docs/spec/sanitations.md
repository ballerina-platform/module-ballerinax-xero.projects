_Author_:  Dimuthu Madushan \
_Created_: 2026/09/30 \
_Updated_: 2026/10/05 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Xero Projects. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/xero/projects/2.0/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Rename the operations to consistent, intent-revealing names. The collection operations use the `list` prefix and the
   HTTP-verb-named `patchProject` becomes `updateProjectStatus`:

   | Original operationId | Updated operationId |
   |---|---|
   | `getProjects` | `listProjects` |
   | `getProjectUsers` | `listProjectUsers` |
   | `getTasks` | `listTasks` |
   | `getTimeEntries` | `listTimeEntries` |
   | `patchProject` | `updateProjectStatus` |

2. Rename the paged wrapper schemas so they read as lists: `Projects` becomes `ProjectList`, `Tasks` becomes `TaskList`,
   `TimeEntries` becomes `TimeEntryList` and `ProjectUsers` becomes `ProjectUserList`.

3. Correct the summary of `PATCH /Projects/{projectId}` in the original spec (`docs/spec/openapi.yaml`), which read
   "creates a project for the specified contact". It is now "Updates the status of a specific project", matching what
   the operation does.

4. Add descriptions, in the original spec (`docs/spec/openapi.yaml`), to the schemas that had none (`Amount`, `Error`, `Pagination`, `Project`, `ProjectCreateOrUpdate`,
   `ProjectPatch`, `ProjectUser`, the list wrappers, `Task`, `TaskCreateOrUpdate`, `TimeEntry` and
   `TimeEntryCreateOrUpdate`).

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
