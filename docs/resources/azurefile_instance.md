---
page_title: "Commvault: commvault_azurefile_instance Resource"
subcategory: "Azure Files"
description: |-
  Creates an Azure File Share instance in the Commvault environment.
---

# commvault_azurefile_instance (Resource)

Creates an Azure File Share instance using `POST /V4/azurefile/instance`.

The supplied OpenAPI specification currently defines only the create operation. The resource therefore treats configuration changes as replacement changes, retains state on refresh, and cannot delete the remote instance until a delete API is available.

## Example Usage

```hcl
resource "commvault_azurefile_instance" "example" {
  name = "terraform-azure-file"

  credential {
    id = 123
  }

  plan {
    id = 456
  }

  region {
    id = 789
  }

  contents {
    path       = ["/"]
    exclusions = ["/temporary"]
    exceptions = ["/temporary/keep.txt"]
  }
}
```

For customer-managed access nodes, use `access_nodes` instead of `region`:

```hcl
resource "commvault_azurefile_instance" "customer_managed" {
  name = "terraform-azure-file-customer-managed"

  credential {
    id = 123
  }

  plan {
    id = 456
  }

  access_nodes {
    id   = 101
    type = "client"
  }
}
```

## Schema

### Required

- `name` (String)
- `credential` (Block List) Azure credential ID or name
- `plan` (Block List) Commvault plan ID or name

### Optional

- `access_nodes` (Block Set) Customer-managed access nodes. Exactly one of `access_nodes` or `region` must be configured.
- `contents` (Block List) Paths, exclusions, and exceptions to protect.
- `host_url` (String) Defaults to `file.core.windows.net`.
- `region` (Block List) Azure region. Exactly one of `region` or `access_nodes` must be configured.
