class profile::wordpress {

  ## Hiera lookups
  $site_name               = hiera('profiles::wordpress::site_name')
  $wordpress_user_password = hiera('profiles::wordpress::wordpress_user_password')
  $mysql_root_password     = hiera('profiles::wordpress::mysql_root_password')
  $wordpress_db_host       = hiera('profiles::wordpress::wordpress_db_host')
  $wordpress_db_name       = hiera('profiles::wordpress::wordpress_db_name')
  $wordpress_db_password   = hiera('profiles::wordpress::wordpress_db_password')
  $wordpress_user          = hiera('profiles::wordpress::wordpress_user')
  $wordpress_group         = hiera('profiles::wordpress::wordpress_group')
  $wordpress_docroot       = hiera('profiles::wordpress::wordpress_docroot')
  $wordpress_port          = hiera('profiles::wordpress::wordpress_port')

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
