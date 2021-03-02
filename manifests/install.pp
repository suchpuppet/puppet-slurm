# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include slurm::install
class slurm::install (
  Hash $packages,
) {
  $package_defaults = {
    'ensure' => 'latest',
  }

  # Merge the above default hash with the looked up data
  $packages.each |String $name, Hash $value| {
    package { $name:
      * => $value + $package_defaults,
    }
  }
}
