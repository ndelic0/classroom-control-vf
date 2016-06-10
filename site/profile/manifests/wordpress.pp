class profile::wordpress {

  group { 'wordpress':
    ensure => present,
  }

  user { 'wordpress':
    ensure => present,
    gid    => 'wordpress',
  }

  include apache
  include apache::mod::php

  include mysql::server
  include mysql::bindings


  include wordpress
}
