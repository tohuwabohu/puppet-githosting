# == Define: githosting::repository
#
# Create a git repository in the service's data directory.
#
define githosting::repository ($service, $data_dir, $ensure = present) {
  validate_string($service)
  validate_absolute_path($data_dir)
  validate_re($ensure, 'present|absent')

  exec { "git_repository_${name}":
    user    => $service,
    command => "/usr/bin/git init --bare ${data_dir}/${name}.git",
    creates => "${data_dir}/${name}.git/HEAD",
    require => [Package['git'], User[$service]],
  }
}
