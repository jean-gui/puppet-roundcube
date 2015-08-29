# Class: roundcube::config
#
# Manage the Roundcube configuration files.
#
# === Authors
#
# Martin Meinhold <martin.meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2013 Martin Meinhold, unless otherwise noted.
#
class roundcube::config inherits roundcube {

  $application_dir = $roundcube::install::target
  $config_file = "${application_dir}/config/config.inc.php"

  if empty($roundcube::db_dsn) {
    $password = uriescape($roundcube::db_password)
    $db_dsnw = "${roundcube::db_type}://${roundcube::db_username}:${password}@${roundcube::db_host}/${roundcube::db_name}"
  }
  else {
    $db_dsnw = $roundcube::db_dsn
  }

  $options_defaults = {
    'db_dsnw'      => $db_dsnw,
    'default_host' => $roundcube::imap_host,
    'default_port' => $roundcube::imap_port,
    'des_key'      => $roundcube::des_key,
    'plugins'      => $roundcube::plugins,
  }

  $options = merge($options_defaults, $roundcube::options_hash)

  concat { $config_file:
    owner => $roundcube::process,
    group => $roundcube::process,
    mode  => '0440',
  }

  Concat::Fragment {
    target  => $config_file,
  }

  concat::fragment { "${config_file}__header":
    content => template('roundcube/config/header.php.erb'),
    order   => '10',
  }

  concat::fragment { "${config_file}__options":
    content => template('roundcube/config/options.php.erb'),
    order   => '20',
  }

  file { '/etc/cron.daily/roundcube-cleandb':
    ensure => link,
    target => "${application_dir}/bin/cleandb.sh"
  }
}
