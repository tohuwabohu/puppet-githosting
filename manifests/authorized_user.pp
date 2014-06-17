# == Define: githosting::authorized_user
#
# Creates a user that is allowed to access the git repositories via ssh.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
define githosting::authorized_user($service, $ensure = present, $username = $name) {
  validate_string($service)
  validate_re($ensure, 'present|absent')
  validate_string($username)

  $key = getparam(Ssh_authorized_key[$username], 'key')
  $type = getparam(Ssh_authorized_key[$username], 'type')

  ssh_authorized_key { "githosting_${username}":
    ensure  => $ensure,
    key     => $key,
    type    => $type,
    user    => $service,
    require => Ssh_authorized_key[$username],
  }
}
