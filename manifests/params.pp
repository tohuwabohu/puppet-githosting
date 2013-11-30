# == Class: githosting::params
#
# Default values for the githosting class
#
class githosting::params {
  $git_package = $::operatingssytem ? {
    default => 'git'
  }
  $git_version = latest
  $service = 'git'
  $service_shell = '/usr/bin/git-shell'
  $data_dir = $::operatingsystem ? {
    default => '/var/git'
  }
  $authorized_users = []
  $repositories = []
}
