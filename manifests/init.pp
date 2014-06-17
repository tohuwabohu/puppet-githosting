# == Class: githosting
#
# Manage git repositories accessible from outside to a group of users.
#
# === Parameters
#
# Document parameters here.
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
# [*service*]
#   The name of the user owning all repositories.
#   default: git
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
  $git_package_ensure = params_lookup('git_package_ensure'),
  $git_package_name   = params_lookup('git_package_name'),
  $git_executable     = params_lookup('git_executable'),
  $service = params_lookup('service'),
  $service_managehome = params_lookup('service_managehome'),
  $service_shell = params_lookup('service_shell'),
  $data_dir = params_lookup('data_dir'),
  $authorized_users = params_lookup('authorized_users'),
  $repositories = params_lookup('repositories'),
) inherits githosting::params {

  if empty($git_package_ensure) {
    fail('Class[Githosting]: git_package_ensure must not be empty')
  }

  if empty($git_package_name) {
    fail('Class[Githosting]: git_package_name must not be empty')
  }
  validate_absolute_path($git_executable)
  validate_string($service)
  validate_string($service_shell)
  validate_absolute_path($githosting::data_dir)
  validate_array($githosting::authorized_users)
  validate_array($githosting::repositories)

  package { $git_package_name:
    ensure => $git_package_ensure,
  }

  user { $githosting::service:
    ensure     => present,
    home       => $githosting::data_dir,
    shell      => $githosting::service_shell,
    managehome => $service_managehome,
    require    => Package[$git_package_name],
  }

  githosting::authorized_user { $authorized_users: }

  githosting::repository { $githosting::repositories: }
}
