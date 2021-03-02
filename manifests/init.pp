# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include slurm
class slurm (
  Enum['monolithic', 'head', 'compute'] $installation_type,
  Boolean $manage_db,
  String $db_user,
  String $db_password,
  String $db_root_password,
  Stdlib::Host $db_host,
  Hash $db_override_options,
  Boolean $manage_munge,
  String $munge_key_source,
  Enum['YES', 'NO'] $disable_root_jobs,
  Enum['YES', 'NO'] $enforce_part_limits,
  Integer $first_job_id,
  Integer $max_job_id,
  Integer[0,1] $group_update_force,
  Integer $group_update_time,
  Integer[0,1] $job_file_append,
  Integer[0,1] $job_requeue,
  Integer[0,1] $job_submit_plugins,
  Integer[0,1] $kill_on_bad_exit,
  String $launch_type,
  String $mail_prog,
  Integer $max_job_count,
  Integer $max_step_count,
  Integer $max_tasks_per_node,
  String $mpi_default,
  String $private_data,
  String $proctrack_type,
  Integer[0,1] $propogate_prio_process,
  Integer[0,1] $return_to_service,
  Stdlib::Absolutepath $slurmctld_pidfile,
  Stdlib::Port $slurmctld_port,
  Stdlib::Absolutepath $slurmd_pidfile,
  Stdlib::Absolutepath $slurmdbd_pidfile,
  Stdlib::Port $slurmd_port,
  String $slurmd_spool_dir,
  String $slurm_user,
  String $task_plugin,
  String $task_plugin_param,
  Integer $batch_start_timeout,
  Integer $complete_wait,
  Integer $get_env_timeout,
  Integer $inactive_limit,
  Integer $kill_wait,
  Integer $message_timeout,
  Integer $resv_over_run,
  Integer $min_job_age,
  Integer $over_time_limit,
  Integer $slurmctld_timeout,
  Integer $slurmd_timeout,
  Integer $unkillable_step_timeout,
  Integer $wait_time,
  Integer $def_mem_per_cpu,
  Integer $max_mem_per_cpu,
  Integer $scheduler_time_slice,
  String $scheduler_type,
  String $select_type,
  String $select_type_parameters,
  Enum['YES', 'NO'] $accounting_job_store_comment,
  String $cluster_name,
  String $job_comp_type,
  String $job_container_type,
  Integer $job_acct_gather_frequency,
  String $job_acct_gather_type,
  Enum['debug', 'error', 'warn', 'info'] $slurmctl_loglevel,
  Enum['debug', 'error', 'warn', 'info'] $slurmd_loglevel,
  Enum['debug', 'error', 'warn', 'info'] $slurmdbd_loglevel,
  Variant[Hash, Undef] $compute_nodes,
  Variant[Hash, Undef] $partitions,
  Array $slurmctld_hosts = [$::fqdn],
) {
  if $manage_db == true {
    require slurm::db
  }

  if $manage_munge == true {
    require slurm::auth
  }

  require slurm::install
  require slurm::config
  require slurm::service
}
