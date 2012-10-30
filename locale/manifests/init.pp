class locale (
  $locales  = 'en_US.UTF-8',
  $lang     = 'en_US.UTF-8',
  $language = 'en_US'
) {

  Exec {
    path => ['/usr/sbin', '/bin', '/usr/bin']
  }

  exec { 'install_locales':
    command => "locale-gen ${locales}",
    notify  => Exec['reload_locales']
  }

  if $lang {
    exec { 'update_default_lang':
      command => "update-locale LANG='${lang}'",
      notify  => Exec['reload_locales'],
      unless  => "locale | grep -e ^LANG=${lang}\$"
    }
  }

  if $language {
    exec { 'update_default_language':
      command => "update-locale LANGUAGE='${language}'",
      notify  => Exec['reload_locales'],
      unless  => "locale | grep -e ^LANGUAGE=${language}\$"
    }
  }

  exec { 'reload_locales':
    command     => "dpkg-reconfigure locales",
    refreshonly => true
  }

}

