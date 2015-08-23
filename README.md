#roundcube

##Overview

Puppet module to install and manage Roundcube, the web-base email client.

##Usage

To install Roundcube with all defaults simply use

```
class { 'roundcube': ]
```

Specify a certain mail server

```
class { 'roundcube':
  imap_host => 'ssl://localhost',
  imap_port => 993,
}
```

Specify the database to be used by Roundcube

```
class { 'roundcube':
  db_type     => 'pgsql',
  db_name     => 'roundcube',
  db_host     => 'localhost',
  db_username => 'roundcube',
  db_password => 'secret',
}
```

or specify the database DSN directly (e.g. when using SQLite)

```
class { 'roundcube':
  db_dsn => 'sqlite:////var/lib/database/roundcube.db?mode=0646',
}
```

Specify a couple of plugins to activate

```
class { 'roundcube':
  plugins => [
    'emoticons',
    'markasjunk2',
    'password',
  ],
}
```

##Advanced usage

Specify advanced parameters

```
class { 'roundcube':
  options_hash {
    'language'    => 'en_US', # override auto-detection
    'support_url' => 'http://example.com/helpdesk',
  }
}
```

See config/defaults.inc.php in the roundcube directory for a complete list of configuration arguments.

##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 6.0 (Squeeze)

[![Build Status](https://travis-ci.org/tohuwabohu/puppet-roundcube.png?branch=master)](https://travis-ci.org/tohuwabohu/puppet-roundcube)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

###Development

This project uses rspec-puppet and beaker to ensure the module works as expected and to prevent regressions.

```
gem install bundler
bundle install --path vendor

bundle exec rake spec
bundle exec rake beaker
```
(note: see [Beaker - Supported ENV variables](https://github.com/puppetlabs/beaker/wiki/How-to-Write-a-Beaker-Test-for-a-Module#beaker-rspec-details)
for a list of environment variables to control the default behaviour of Beaker)
