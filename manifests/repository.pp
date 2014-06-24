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
define githosting::repository($repository = $title, $ensure = present) {
  if $ensure !~ /^present|absent$/ {
    fail("Githosting::Repository[${title}]: ensure must be either present or absent, got '${ensure}'")
  }

  include githosting

  $repository_dir = "${githosting::data_dir}/${repository}.git"
  $repository_ensure = $ensure ? {
    absent  => absent,
    default => bare,
  }

  vcsrepo { $repository_dir:
    ensure   => $repository_ensure,
    provider => git,
    user     => $githosting::service_name,
  }
}
