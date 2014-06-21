# == Define: githosting::authorized_user
#
# Creates a user that is allowed to access the git repositories via ssh. The ssh key is read from a
# `ssh_authorized_key` resource.
#
# === Parameters
#
# [*ensure*]
#   Set the state the user authorization should be in: either present or absent.
#
# [*username*]
#   Set the name of the user who should be allowed to access the repository.
#
# [*key*]
#   Set the public key to be used to authenticate the referenced user; if not specified, the key will be looked up from
#   the `ssh_authorized_key` resource of the user.
#
# [*type*]
#   Set the type of the public key to be used to authenticated the reference user; if not not specified, the type will
#   looked up from the `ssh_autorized_key` resource of the user.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
define githosting::authorized_user(
  $ensure   = present,
  $username = $title,
  $key      = undef,
  $type     = undef
) {
  if $ensure !~ /^present|absent$/ {
    fail("Githosting::Authorized_User[${title}]: ensure must be either present or absent, got '${ensure}'")
  }
  if empty($username) {
    fail("Githosting::Authorized_User[${title}]: username must not be empty")
  }

  include githosting

  $real_key = empty($key) ? {
    true    => getparam(Ssh_authorized_key[$username], 'key'),
    default => $key,
  }
  $real_type = empty($type) ? {
    true    => getparam(Ssh_authorized_key[$username], 'type'),
    default => $type,
  }

  ssh_authorized_key { "githosting_${username}":
    ensure  => $ensure,
    key     => $real_key,
    type    => $real_type,
    user    => $githosting::service_name,
    require => Ssh_authorized_key[$username],
  }
}
