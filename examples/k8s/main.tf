# -----------------------------------------------------------------------
# Kubernetes Cluster – Activity Control example (K8S-004)
#
# Demonstrates the correct usage of enablebackupafteradelay and
# enablerestoreafteradelay.  These delay fields are ONLY honoured by
# CommCell when the corresponding enable flag is "false".  Setting a
# delay while the flag is "true" has no effect.
#
# Scenario A (default): cluster is fully active — no delay fields set.
# Scenario B (maintenance): backup and restore are suspended until a
#   specific UTC Unix timestamp, after which CommCell re-enables them
#   automatically.
# -----------------------------------------------------------------------

resource "commvault_kubernetes_cluster" "example" {
  name = var.cluster_name

  # Access node (MediaAgent) that CommCell uses to reach the API server
  accessnodes {
    id   = var.access_node_id
    type = 3 # 3 = MediaAgent
  }

  # -----------------------------------------------------------------------
  # Activity Control
  #
  # SCENARIO A – normal operation (comment out the delay fields or set
  # them to 0):
  #   enablebackup  = "true"
  #   enablerestore = "true"
  #
  # SCENARIO B – temporary maintenance window:
  #   enablebackup              = "false"
  #   enablebackupafteradelay   = <future UTC Unix timestamp>
  #   enablerestore             = "false"
  #   enablerestoreafteradelay  = <future UTC Unix timestamp>
  #
  # WARNING: setting enablebackupafteradelay when enablebackup = "true"
  # is silently ignored by the API.  The delay only activates when the
  # corresponding enable flag is "false".
  # -----------------------------------------------------------------------
  activitycontrol {
    enablebackup  = "false"
    enablerestore = "false"

    # Re-enable backup automatically at this UTC Unix timestamp.
    # Only honoured because enablebackup = "false" above.
    enablebackupafteradelay = var.backup_re_enable_timestamp

    # Re-enable restore automatically at this UTC Unix timestamp.
    # Only honoured because enablerestore = "false" above.
    enablerestoreafteradelay = var.restore_re_enable_timestamp
  }

  # Backup plan that provides the default schedule for the cluster
  plan {
    id = var.plan_id
  }
}
