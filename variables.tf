variable "database_cloud_vm_clusters" {
  description = <<EOT
Map of database_cloud_vm_clusters, attributes below
Required:
    - backup_subnet_id
    - cloud_exadata_infrastructure_id
    - compartment_id
    - cpu_core_count
    - display_name
    - gi_version
    - hostname
    - ssh_public_keys
    - subnet_id
Optional:
    - backup_network_nsg_ids
    - cluster_name
    - create_async
    - data_storage_percentage
    - data_storage_size_in_tbs
    - db_node_storage_size_in_gbs
    - db_servers
    - defined_tags
    - domain
    - exascale_db_storage_vault_id
    - freeform_tags
    - is_local_backup_enabled
    - is_sparse_diskgroup_enabled
    - license_model
    - memory_size_in_gbs
    - node_count
    - nsg_ids
    - ocpu_count
    - private_zone_id
    - reco_storage_percentage
    - scan_listener_port_tcp
    - scan_listener_port_tcp_ssl
    - security_attributes
    - sparse_storage_percentage
    - subscription_id
    - system_version
    - tde_key_store_type
    - time_zone
    - vm_backup_storage_type
    - vm_cluster_type
    - vm_file_system_storage_type
    - cloud_automation_update_details (block):
        - apply_update_time_preference (optional, block):
            - apply_update_preferred_end_time (optional)
            - apply_update_preferred_start_time (optional)
        - freeze_period (optional, block):
            - freeze_period_end_time (optional)
            - freeze_period_start_time (optional)
        - is_early_adoption_enabled (optional)
        - is_freeze_period_enabled (optional)
    - data_collection_options (block):
        - is_diagnostics_events_enabled (optional)
        - is_health_monitoring_enabled (optional)
        - is_incident_logs_enabled (optional)
    - file_system_configuration_details (block):
        - file_system_size_gb (optional)
        - mount_point (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - update_details (block):
        - update_action (optional)
        - update_id (optional)
        - update_mode (optional)
EOT

  type = map(object({
    backup_subnet_id                = string
    cloud_exadata_infrastructure_id = string
    compartment_id                  = string
    cpu_core_count                  = number
    display_name                    = string
    gi_version                      = string
    hostname                        = string
    ssh_public_keys                 = list(string)
    subnet_id                       = string
    backup_network_nsg_ids          = optional(set(string))
    cluster_name                    = optional(string)
    create_async                    = optional(bool)
    data_storage_percentage         = optional(number)
    data_storage_size_in_tbs        = optional(number)
    db_node_storage_size_in_gbs     = optional(number)
    db_servers                      = optional(list(string))
    defined_tags                    = optional(map(string))
    domain                          = optional(string)
    exascale_db_storage_vault_id    = optional(string)
    freeform_tags                   = optional(map(string))
    is_local_backup_enabled         = optional(bool)
    is_sparse_diskgroup_enabled     = optional(bool)
    license_model                   = optional(string)
    memory_size_in_gbs              = optional(number)
    node_count                      = optional(number)
    nsg_ids                         = optional(set(string))
    ocpu_count                      = optional(number)
    private_zone_id                 = optional(string)
    reco_storage_percentage         = optional(number)
    scan_listener_port_tcp          = optional(number)
    scan_listener_port_tcp_ssl      = optional(number)
    security_attributes             = optional(map(string))
    sparse_storage_percentage       = optional(number)
    subscription_id                 = optional(string)
    system_version                  = optional(string)
    tde_key_store_type              = optional(string)
    time_zone                       = optional(string)
    vm_backup_storage_type          = optional(string)
    vm_cluster_type                 = optional(string)
    vm_file_system_storage_type     = optional(string)
    cloud_automation_update_details = optional(object({
      apply_update_time_preference = optional(object({
        apply_update_preferred_end_time   = optional(string)
        apply_update_preferred_start_time = optional(string)
      }))
      freeze_period = optional(object({
        freeze_period_end_time   = optional(string)
        freeze_period_start_time = optional(string)
      }))
      is_early_adoption_enabled = optional(bool)
      is_freeze_period_enabled  = optional(bool)
    }))
    data_collection_options = optional(object({
      is_diagnostics_events_enabled = optional(bool)
      is_health_monitoring_enabled  = optional(bool)
      is_incident_logs_enabled      = optional(bool)
    }))
    file_system_configuration_details = optional(list(object({
      file_system_size_gb = optional(number)
      mount_point         = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    update_details = optional(object({
      update_action = optional(string)
      update_id     = optional(string)
      update_mode   = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.database_cloud_vm_clusters : (
        v.tde_key_store_type == null || (contains([for v in ["OCI", "AWS", "AZURE", "GCP", "NONE"] : lower(v)], lower(v.tde_key_store_type)))
      )
    ])
    error_message = "must be one of: \"OCI\", \"AWS\", \"AZURE\", \"GCP\", \"NONE\""
  }
}

