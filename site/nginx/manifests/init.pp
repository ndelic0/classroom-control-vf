class nginx (
  $docroot = '/var/www',
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0664',
  }

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { [ '/etc/nginx/conf.d', '/var/www' ]:
    ensure => directory,
    mode   => '0775',
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "${docroot}/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}
