# == Class: githosting
#
# Manage git repositories accessible from outside to a group of users.
#
# === Parameters
#
# [*ensure*]
#   The state the githosting should be in: either present or absent. Absent will remove any existing data.
#   default: present
#
# [*git_package_name*]
#   Sets the name of the package containing the git executable.
#   default: git
#
# [*git_package_ensure*]
#   The state the git package should be in.
#   default: latest
#
# [*service_name*]
#   The name of the user owning all repositories.
#   default: git
#
# [*service_uid*]
#   The UID of the service user. Useful in combination with backup and restore.
#   default: undef
#
# [*service_gid*]
#   The GID of the service user. Useful in combination with backup and restore.
#   default: undef
#
# [*service_shell*]
#   Sets the services' shell.
#   default: /usr/bin/git-shell
#
# [*data_dir*]
#   The directory where all git repositories are stored.
#   default: /var/git
#
# [*authorized_users*]
#   Sets an array of username allowed to acces the repository via ssh. It is expected that there
#   is an ssh_authorized_key resourced defined for each username containing the referenced key.
#   default: []
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
  $ensure             = $githosting::params::ensure,
  $git_package_ensure = $githosting::params::git_package_ensure,
  $git_package_name   = $githosting::params::git_package_name,
  $service_name       = $githosting::params::service_name,
  $service_uid        = $githosting::params::service_uid,
  $service_gid        = $githosting::params::service_gid,
  $service_shell      = $githosting::params::service_shell,
  $data_dir           = $githosting::params::data_dir,
  $authorized_users   = $githosting::params::authorized_users,
  $repositories       = $githosting::params::repositories,
) inherits githosting::params {

  if $ensure !~ /^present|absent$/ {
    fail("Class[Githosting]: ensure must be either present or absent, got '${ensure}'")
  }
  if empty($git_package_ensure) {
    fail('Class[Githosting]: git_package_ensure must not be empty')
  }
  if empty($git_package_name) {
    fail('Class[Githosting]: git_package_name must not be empty')
  }
  if empty($service_name) {
    fail('Class[Githosting]: service_name must not be empty')
  }
  validate_absolute_path($service_shell)
  validate_absolute_path($githosting::data_dir)
  validate_array($githosting::authorized_users)
  validate_array($githosting::repositories)

  package { $git_package_name:
    ensure => $git_package_ensure,
  }

  group { $service_name:
    ensure => present,
    gid    => $service_gid,
    system => true,
  }

  user { $service_name:
    ensure     => $ensure,
    uid        => $service_uid,
    gid        => $service_name,
    home       => $data_dir,
    shell      => $service_shell,
    managehome => true,
    system     => true,
    require    => Package[$git_package_name],
  }

  githosting::authorized_user { $authorized_users:
    ensure => $ensure,
  }

  githosting::repository { $githosting::repositories:
    ensure => $ensure,
  }

  Githosting::Authorized_user <| |> -> Githosting::Repository <| |>
}
