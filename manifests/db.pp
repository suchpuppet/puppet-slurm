# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include slurm::db
class slurm::db {
  include slurm

  $user        = $slurm::slurm_user
  $pidfile     = $slurm::slurmdbd_pidfile
  $db_host     = $slurm::db_host
  $db_password = Sensitive($slurm::db_password)
  $db_user     = $slurm::db_user

  $debug_level = $slurm::slurmdbd_loglevel ? {
    'error' => 3,
    'warn'  => 4,
    'info'  => 6,
    'debug' => 7,
  }

  if $::slurm::manage_db == true {
    class { 'mysql::server':
      package_name            => 'mariadb-server',
      root_password           => $::slurm::db_root_password,
      remove_default_accounts => true,
      restart                 => true,
      override_options        => $::slurm::db_override_options,
    }

    mysql::db { 'slurm_acct_db':
      user     => $::slurm::db_user,
      password => $::slurm::db_password,
      host     => $::slurm::db_host,
      grant    => ['ALL'],
    }
  }

  # Install MariaDB Client
  class { '::mysql::client':
    package_name    => 'mariadb-client',
    bindings_enable => true,
  }

  # Configure Slurm DB backend
  file { '/etc/slurm-llnl/slurmdbd.conf':
    ensure  => 'file',
    owner   => $slurm::slurm_user,
    group   => $slurm::slurm_user,
    mode    => '0640',
    content => template('slurm/slurmdbd.conf.erb'),
    notify  => Class['slurm::service'],
  }
}
