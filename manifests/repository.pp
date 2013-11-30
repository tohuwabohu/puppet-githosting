# == Define: githosting::repository
#
# Create a git repository in the service's data directory.
#
define githosting::repository ($ensure = present, $service, $data_dir) {
  validate_absolute_path($data_dir)

  exec { "git_repository_${name}":
    user    => $service,
    command => "/usr/bin/git init --bare ${data_dir}/${name}.git",
    creates => "${data_dir}/${name}.git/HEAD",
    require => [Package['git'], User[$service]],
  }
}
