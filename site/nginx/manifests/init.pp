class nginx {

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/conf.d':
    ensure => directory,
    mode   => '0775',
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/var/www':
    ensure => directory,
  }

  file {'/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}
