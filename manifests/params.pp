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
  $git_package = $::operatingssytem ? {
    default => 'git'
  }
  $git_version = latest
  $git_executable = $::operatingsystem ? {
    default => '/usr/bin/git'
  }
  $service = 'git'
  $service_managehome = true
  $service_shell = '/usr/bin/git-shell'
  $data_dir = $::operatingsystem ? {
    default => '/var/git'
  }
  $authorized_users = []
  $repositories = []
}
