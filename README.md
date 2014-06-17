#githosting

##Overview

Puppet module to manage a simple, ssh-based git repository hosting service.

##Usage

Setup githosting with a couple of repositories:

```
class { 'githosting':
  repositories => [
    'repository1',
    'repository2',
  ],
}
```

Alternatively, you can create more repositories via:

```
githosting::repository { 'repo1': }
```

or even drop an existing on:

```
githosting::repository { 'attic':
  ensure => absent,
}
```

To authorize a user to access the system, simply use a snippet like

```
ssh_authorized_key { "githosting_foobar":
  key  => '<key goes here>',
  type => 'ssh-rsa',
  user => $githosting::service,
}
```

or use the existing definition assuming there's a `Ssh_Authorized_Key['foobar']` resource existing:

```
githosting::authorized_user { 'foobar': }
```

##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 6.0 (Squeeze)

[![Build Status](https://travis-ci.org/tohuwabohu/tohuwabohu-githosting.png?branch=master)](https://travis-ci.org/tohuwabohu/tohuwabohu-githosting)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
