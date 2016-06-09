define users::managed_user (
 group => $title,
)
{

  user { $title:
    ensure => present,
    group  => $group,
  }
  
  file { "/home/${title}":
    ensure => directory,
    owner  => $title,
    group  => $title,
  }

}
