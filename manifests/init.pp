# == Class: githosting
#
# Manage git repositories accessible from outside to a group of users.
#
# === Parameters
#
# Document parameters here.
#
# [*git_version*]
#   The version of git to be installed
#   default: latest
#
# [*service*]
#   The name of the user owning all repositories
#   default: git
#
# [*data_dir*]
#   The directory where all git repositories are stored
#   default: /var/git
#
# [*repositories*]
#   Sets an array of repositories to be created. The trailing .git can be omitted.
#   default: []
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold
#
class githosting (
  $git_version = params_lookup('git_version'),
  $service = params_lookup('service'),
  $data_dir = params_lookup('data_dir'),
  $repositories = params_lookup('repositories')
) inherits githosting::params {
  validate_absolute_path($githosting::data_dir)
  validate_array($githosting::repositories)

  package { 'git': ensure => $githosting::git_version }

  user { $githosting::service:
    ensure     => present,
    home       => $githosting::data_dir,
    shell      => '/usr/bin/git-shell',
    managehome => true,
    require    => Package['git'],
  }

  githosting::repository { $githosting::repositories:
    ensure   => present,
    service  => $githosting::service,
    data_dir => $githosting::data_dir,
  }
}
