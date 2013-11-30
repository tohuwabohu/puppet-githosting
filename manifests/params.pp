# == Class: githosting::params
#
# Default values for the githosting class
#
class githosting::params {
  $git_version = latest
  $service = 'git'
  $data_dir = $::operatingsystem ? {
    default => '/var/git'
  }
  $repositories = []
}
