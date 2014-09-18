#
# Timezone -> America/Sao_Paulo
#

package {'tzdata':
  ensure  => 'present'
}

file {'/etc/localtime':
  require => Package['tzdata'],
  source  => 'file:///usr/share/zoneinfo/America/Sao_Paulo',
  notify  => Exec['reboot']
}

file {'/etc/timezone':
  content => 'America/Sao_Paulo',
}