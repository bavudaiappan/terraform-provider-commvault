---
page_title: " Commvault : commvault_company Resource"
subcategory: "Company"
description: |-
  Use the commvault_company resource type to create or delete a Company in the Commcell environment.
---

# commvault_company (Resource)

Use the commvault_company resource type to create or delete a Company in the Commcell environment.


## Syntax

```
resource "commvault_company" "<local name>"{
	company_name = "<Company Name>"
	email = "<Email ID>"
	contact_name = "<Contact Name>"
	company_alias = "<Company Alias>"
	plans = toset(["<Plan name1>", "<Plan name2>"])
	associated_smtp = "<SMTP Server>"
	send_email = <Boolean values: true or false>
}

```

## Example Usage

```
resource "commvault_company" "Company1"{
	company_name = "CompanyName"
	email = "DemoCompany@company.com"
	contact_name = "ContactName"
	company_alias = "CompanyAlias"
	plans = toset(["Plan1", "Plan2"])
	associated_smtp = "SMTP_Server"
	send_email = false
}

```
## Deletion and Resource Cleanup

<<<<<<< Updated upstream
When a company resource is destroyed with `terraform destroy`, the provider performs a two-step deletion sequence:

1. **Deactivate**: Disables backup, restore, and login capabilities for the company (via `POST /Organization/{id}/action/deactivate`)
2. **Delete**: Removes the company from the Commcell environment (via `DELETE /Organization/{id}`)

### Backend Resource Disassociation

Resource disassociation (plans, associated entities, billing relationships, etc.) is **handled entirely by the Commvault backend**, not by the Terraform provider. The backend ensures:

- Associated plans remain available to other companies (plans are not deleted when a company is removed)
- Active jobs and backups for this company are handled per Commvault retention and dependency policies
- Child companies (if this is a parent) are managed per Commvault organizational rules
- User access and role associations are cleaned up according to backend policies

### Troubleshooting Deletion Failures

If `terraform destroy` fails with an error during company deletion, the issue is typically a **backend-side dependency or policy restriction**, not a Terraform provider issue. Common causes include:

- **Active jobs or retention periods**: Commvault may prevent deletion if backup jobs are active or data is within retention windows. Ensure all active jobs are complete and retention periods have expired.
- **Child companies exist**: If this is a parent company, verify no child companies are associated before deletion.
- **User sessions**: Active user sessions from this company may block deactivation/deletion. Log out all users and retry.
- **Billing or license holds**: Some Commvault environments enforce billing dependencies before allowing company deletion.

**Resolution**: Review the Commvault GUI for this company's resource dependencies (Jobs, Users, Subclients, etc.) before attempting deletion. The Commvault administrator should verify the company can be safely removed before running `terraform destroy`.
=======
### plans Declaration Behavior

The `plans` argument is a **set of strings** (`schema.TypeSet`), not an ordered list.

- Order does not matter (`["Plan1", "Plan2"]` is equivalent to `["Plan2", "Plan1"]`)
- Duplicate plan names are collapsed to a single value
- Use `toset([...])` in examples to make set semantics explicit

>>>>>>> Stashed changes
### Required

- **company_name** (String) Specifies the name of the Company.
- **email** (String) Specifies Email address for the tenant administrator.
- **contact_name** (String) Specifies Name of the tenant administrator.
- **company_alias** (String) Specifies the Alias name for the company.

### Optional

- **associated_smtp** (String) Specifies the SMTP address of the company.
- **send_email** (Boolean) Specifies whether email needs to be sent ot not
- **plans** (Set of String) Specifies the data protection plans to use for the company. This argument is an unordered set. The plans you select are the plans that the tenant administrator can choose from.
- **company_id** (Number) Specifies the company id to which the child company should be associated with.
- **id** (String) The ID of this resource.
