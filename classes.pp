class tracy {
  include ntp
  include vim
  include ps1
  include sshd
  include postfix
  include users
}

class tracy::webserver inherits tracy {
  include nginx
}

class tracy::mysqlserver inherits tracy {
  include mysql
}
