# == Class: githosting
#
# Manage git repositories accessible from outside to a group of users.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold
#
class githosting {

  package { 'git': ensure => latest }

  user { 'git':
    ensure     => present,
    home       => '/var/git',
    shell      => '/usr/bin/git-shell',
    managehome => true,
    require    => Package['git'],
  }
}
