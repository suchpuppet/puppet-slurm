# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include slurm::db
class slurm::db {
  include slurm

  if $::slurm::manage_db == true {
    class { 'mysql::server':
      package_name            => 'mariadb-server',
      root_password           => $::slurm::db_root_password,
      remove_default_accounts => true,
      restart                 => true,
      override_options        => $::slurm::db_override_options,
    }

    mysql::db { 'slurm':
      user     => $::slurm::db_user,
      password => $::slurm::db_password,
      host     => $::slurm::db_host,
      grant    => ['ALL'],
    }
  }
}
