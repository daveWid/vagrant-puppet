exec { 'apt-get-update':
  command => 'apt-get update',
  path    => '/usr/bin/',
  timeout => 60,
  tries   => 3,
}

class { 'apt':
  always_apt_update => false,
}

package { ['python-software-properties']:
  ensure  => 'installed',
  require => Exec['apt-get-update'],
}

file { '/home/vagrant/.bash_aliases':
  ensure => 'present',
  source => 'puppet:///modules/puphpet/dot/.bash_aliases',
}

package { [
    'build-essential',
    'vim',
    'curl'
  ]:
  ensure  => 'installed',
  require => Exec['apt-get-update'],
}

class { 'apache':
  require => Exec['apt-get-update'],
}

apache::dotconf { 'custom':
  content => 'EnableSendfile Off',
}

apache::module { 'rewrite': }

apache::vhost { 'default':
  server_name => false,
  docroot     => '/var/www/html',
  port        => '80',
  priority    => ''
}

class { 'php':
  service       => 'apache',
  module_prefix => '',
  require       => [Exec['apt-get-update'], Package['apache']],
}

php::module { 'php5-mysql': }
php::module { 'php5-cli': }
php::module { 'php5-curl': }
php::module { 'php5-intl': }
php::module { 'php5-mcrypt': }

class { 'php::devel':
  require => Class['php'],
}

class { 'php::pear':
  require => Class['php'],
}

class { 'xdebug':
  service => 'apache',
}

class { 'composer':
  require => Package['php5', 'curl'],
}

puphpet::ini { 'xdebug':
  value   => [
    'xdebug.default_enable = 1',
    'xdebug.remote_autostart = 0',
    'xdebug.remote_connect_back = 1',
    'xdebug.remote_enable = 1',
    'xdebug.remote_handler = "dbgp"',
    'xdebug.remote_port = 9000'
  ],
  ini     => '/etc/php5/conf.d/zzz_xdebug.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'php':
  value   => [
    'date.timezone = "America/Detroit"',
    'html_errors = On'
  ],
  ini     => '/etc/php5/conf.d/zzz_php.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'custom':
  value   => [
    'display_errors = On',
    'error_reporting = -1'
  ],
  ini     => '/etc/php5/conf.d/zzz_custom.ini',
  notify  => Service['apache'],
  require => Class['php'],
}


class { 'mysql':
  root_password => '',
  require       => Exec['apt-get-update'],
}


class { 'phpmyadmin':
  require => Class['mysql'],
}

file { '/etc/apache2/conf.d/phpmyadmin.conf':
  ensure => 'link',
  target => '/etc/phpmyadmin/apache.conf',
  notify  => Service['apache'],
  require => [Package['apache'], Class['phpmyadmin']],
}

class { 'nodejs': }
