# == Class: githosting::params
#
# Default values for the githosting class
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
class githosting::params {
  $git_package_ensure = latest
  $git_package_name = $::operatingssytem ? {
    default => 'git'
  }
  $git_executable = $::operatingsystem ? {
    default => '/usr/bin/git'
  }

  $service_name = 'git'
  $service_shell = '/usr/bin/git-shell'

  $data_dir = $::operatingsystem ? {
    default => '/var/git'
  }
  $authorized_users = []
  $repositories = []
}
