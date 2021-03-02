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
