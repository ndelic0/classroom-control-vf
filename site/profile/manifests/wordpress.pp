class profile::wordpress {

  group { 'wordpress':
    ensure => present,
  }

  user { 'wordpress':
    ensure => present,
    git    => 'wordpress',
  }

  include apache
  include apache::mod::php

  include mysql::server
  include mysql::server::bindings


  include wordpress
}
