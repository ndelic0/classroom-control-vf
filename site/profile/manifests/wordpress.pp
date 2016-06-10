class profile::wordpress {
  include apache
  include wordpress
  include mysql::client

}

