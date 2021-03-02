# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include slurm::service
class slurm::service {
  include slurm
  include slurm::config
  include slurm::install

  $services = $slurm::installation_type ? {
    'head'    => ['slurmctld', 'slurmdbd'],
    'compute' => ['slurmd'],
    default   => ['slurmctld', 'slurmdbd', 'slurmd']
  }

  $services.each |String $name| {
    service { $name:
      ensure    => 'running',
      enable    => true,
      subscribe => Class['slurm::config', 'slurm::install'],
    }
  }
}
