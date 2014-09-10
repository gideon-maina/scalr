#Tis class will makke sure that all the dependencies are installed and met.

class scalr::install  (
#Declare the parameters to be used from the parameters class
$php = $scalr::params::php,
$php_sockets = $scalr::params::php_sockets,
$php_gettext = $scalr::params::php_gettext,
$php_mcrypt = $scalr::params::php5_mcrypt,
$php_pcntl = $scalr::params::php_pcntl,
$php_posix = $scalr::params::php_posix,
$php_dom = $scalr::params::php_dom,
$php_soap = $scalr::params::php_soap,
$php_mysqli = $scalr::params::php_mysqli,
$php_snmp = $scalr::params::php_snmp,
$php_curl = $scalr::params::php_curl,
$php_ldap = $scalr::params::php_ldap,
$python_dev = $scalr::params::python_dev,
$python_libevent = $scalr::params::$python_libevent,
$python_pip = $scalr::params::python_pip,
$snmp_mibs = $scalr::params::snmp_mibs,
$rrdtool = $scalr::params::rrdtool,
$rrdcached = $scalr::params::rrdcached,
$apache = $scalr::params::apache,
$cron = $scalr::params::cron

) 

inherits scalr::params {
	#Php dependencies using system package manager
	package {'Php':
		name => $php,
		ensure => present

	}
	#Php extensions using system package manager
	package {'php sockets':
		name => $php_sockets,
		ensure => present

	}
	package {'php gettext': 
		name => $php_gettext,
		ensure => present

	}
	package {'phpmcrypt':
		name => $php_mcrypt,
		ensure => present

	}
	package {'php pcnt':
		name => $php_pcntl,
		ensure => present

	}
	package {'php posix':
		name => $php_posix,
		ensure => present
	}
	package {'php dom':
		name => $php_dom,
		ensure => present

	}
	package {'php soap':
		name => $php_soap,
		ensure => present

	}
	package {'php mysqli':
		name=> $php_mysqli,
		ensure => present
	}
	package {'php snmp':
		name => $php_snmp,
		ensure => present

	}
	package {'php curl ':
		name => $php_curl,
		ensure => present

	}
	package {'php ldap':
		name => $php_ldap,
		ensure => present

	}
	#Python packages using pip
	package {'python dev':
		name => $python_dev,
		ensure = present

	}
	package {'python libevent':
		name => $python_libevent,
		ensure => present
	}
	package {'Python pip':
		name => $python_pip,
		ensure => present
	}	

	#Php Pecls using pecl

	#Ensure  upto date SNMP MIBS
	package {'snmp mibs':
		name => $snmp_mibs,
		ensure => present
	}

	#Get the latest source scalr(download) to the install_directory

	#Install Mysql 

	#Install rrdtool,rrdcached using using system package manager
	package {'rrdtool':
		name => $rrdtool,
		ensure => present
	}
	package {'rrdcached':
		name => $rrdcached,
		ensure => present
	}
	#Install Apache2 Web server using system package manager
	package {'apache web server':
		name => $apache,
		ensure => present
	}
	packaged {"Cron jobs":
		name => $cron,
		ensure => present
	}

}