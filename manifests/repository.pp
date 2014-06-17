# == Define: githosting::repository
#
# Create a git repository in the service's data directory.
#
# === Parameters
#
# [*repository*]
#   Sets the name of the repository to be created.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
define githosting::repository($repository = $title) {
  require githosting

  $repository_dir = "${githosting::data_dir}/${repository}.git"

  exec { "${githosting::git_executable} init --bare ${repository_dir}":
    user    => $githosting::service,
    creates => "${repository_dir}/HEAD",
    require => [
      File[$githosting::data_dir],
      User[$githosting::service],
    ],
  }
}
