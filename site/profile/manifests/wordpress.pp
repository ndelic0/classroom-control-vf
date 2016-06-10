class profile::wordpress {

  ## Hiera lookups
  $site_name               = hiera('profile::wordpress::site_name')
  $wordpress_user_password = hiera('profile::wordpress::wordpress_user_password')
  $mysql_root_password     = hiera('profile::wordpress::mysql_root_password')
  $wordpress_db_host       = hiera('profile::wordpress::wordpress_db_host')
  $wordpress_db_name       = hiera('profile::wordpress::wordpress_db_name')
  $wordpress_db_password   = hiera('profile::wordpress::wordpress_db_password')
  $wordpress_user          = hiera('profile::wordpress::wordpress_user')
  $wordpress_group         = hiera('profile::wordpress::wordpress_group')
  $wordpress_docroot       = hiera('profile::wordpress::wordpress_docroot')
  $wordpress_port          = hiera('profile::wordpress::wordpress_port')

  ## Create user
  group { 'wordpress':
    ensure => present,
    name   => $wordpress_group,
  }
  user { 'wordpress':
    ensure   => present,
    gid      => $wordpress_group,
    password => $wordpress_user_password,
    name     => $wordpress_group,
    home     => $wordpress_docroot,
  }

  package { [ 'php','php-mbstring','php-pear' ]:
    ensure => present,
  }
  ## Configure mysql
  class { 'mysql::server':
    root_password => $wordpress_root_password,
  }

  class { 'mysql::bindings':
    php_enable => true,
  }

  ## Configure apache
  include apache
  include apache::mod::php
  apache::vhost { $::fqdn:
    port    => $wordpress_port,
    docroot => $wordpress_docroot,
  }

  ## Configure wordpress
  class { '::wordpress':
    install_dir => $wordpress_docroot,
    db_name     => $wordpress_db_name,
    db_host     => $wordpress_db_host,
    db_password => $wordpress_db_password,
  }
}
