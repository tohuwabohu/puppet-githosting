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
# [*git_executable*]
#   Sets the path to the git executable.
#   default: /usr/bin/git
#
# [*service_name*]
#   The name of the user owning all repositories.
#   default: git
#
# [*service_uid*]
#   The UID of the service user. Useful in combination with backup and restore.
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
  $ensure             = params_lookup('ensure'),
  $git_package_ensure = params_lookup('git_package_ensure'),
  $git_package_name   = params_lookup('git_package_name'),
  $git_executable     = params_lookup('git_executable'),
  $service_name       = params_lookup('service_name'),
  $service_uid        = params_lookup('service_uid'),
  $service_shell      = params_lookup('service_shell'),
  $data_dir           = params_lookup('data_dir'),
  $authorized_users   = params_lookup('authorized_users'),
  $repositories       = params_lookup('repositories'),
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
  validate_absolute_path($git_executable)
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

  user { $githosting::service_name:
    ensure         => $ensure,
    uid            => $service_uid,
    home           => $data_dir,
    shell          => $service_shell,
    managehome     => true,
    purge_ssh_keys => true,
    require        => Package[$git_package_name],
  }

  githosting::authorized_user { $authorized_users:
    ensure => $ensure,
  }

  githosting::repository { $githosting::repositories:
    ensure => $ensure,
  }
}
