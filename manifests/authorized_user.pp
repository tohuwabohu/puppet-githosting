# == Define: githosting::authorized_user
#
# Creates a user that is allowed to access the git repositories via ssh. The ssh key is read from a
# `ssh_authorized_key` resource.
#
# === Parameters
#
# [*ensure*]
#   Sets the state the user authorization should be in: either present or absent.
#
# [*username*]
#   Sets the name of the user who should be allowed to access the repository.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
define githosting::authorized_user($ensure = present, $username = $title) {
  if $ensure !~ /^present|absent$/ {
    fail("Githosting::Authorized_User[${title}]: ensure must be either present or absent, got '${ensure}'")
  }
  if empty($username) {
    fail("Githosting::Authorized_User[${title}]: username must not be empty")
  }

  include githosting

  $key = getparam(Ssh_authorized_key[$username], 'key')
  $type = getparam(Ssh_authorized_key[$username], 'type')

  ssh_authorized_key { "githosting_${username}":
    ensure  => $ensure,
    key     => $key,
    type    => $type,
    user    => $githosting::service_name,
    require => Ssh_authorized_key[$username],
  }
}
