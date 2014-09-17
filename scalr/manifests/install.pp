#Tis class will makke sure that all the dependencies are installed and met.

class scalr::install  (
#Declare the parameters to be used from the parameters class
$php = $scalr::params::php,
$php_sockets = $scalr::params::php_sockets,
$php_gettext = $scalr::params::php_gettext,
$php_mcrypt = $scalr::params::php_mcrypt,
$php_pcntl = $scalr::params::php_pcntl,
$php_posix = $scalr::params::php_posix,
$php_dom = $scalr::params::php_dom,
$php_soap = $scalr::params::php_soap,
$php_mysqli = $scalr::params::php_mysqli,
$php_snmp = $scalr::params::php_snmp,
$php_curl = $scalr::params::php_curl,
$php_ldap = $scalr::params::php_ldap,
$python_dev = $scalr::params::python_dev,
$python_libevent = $scalr::params::python_libevent,
$python_pip = $scalr::params::python_pip,
$python_rrdtool = $scalr::params::python_rrdtool,
$pecl_http = $scalr::params::pecl_http,
$pecl_rrd = $scalr::params::pecl_rrd,
$pecl_yaml = $scalr::params::pecl_yaml,
$pecl_ssh2 = $scalr::params::pecl_ssh2,
$snmp_mibs = $scalr::params::snmp_mibs,
$rrdtool = $scalr::params::rrdtool,
$rrdcached = $scalr::params::rrdcached,
$apache = $scalr::params::apache,
$cron = $scalr::params::cron,
$python_m2crypto = $scalr::params::python_m2crypto,
$python_snmp = scalr::params::python_snmp,
$snmp_base = scalr::params::snmp_base,
$snmp15 = scalr::params::snmp15,
$snmp = scalr::params::snmp,
$scalr_source_url = scalr::params::scalr_source_url,
$scalr_install_dir = scalr::params::scalr_install_dir,
$scalr_tar_target = scalr::params::scalr_tar_target
) 

inherits scalr::params {
	# Global setttings
	Exec { 
		path => [ "/bin/","/usr/bin", "/usr/local/sbin/" , "/usr/local/bin/" ] 
	}
	#Php dependencies using system package manager
	#Php extensions using system package manager
	$php_packages = [$php,$php_sockets,$php_gettext,$php_mcrypt,$php_pcntl,$php_posix,$php_dom,$php_soap,$php_mysqli,$php_snmp,$php_curl,$php_ldap,]

	package {$php_packages:
		ensure => present,
	}
	#Php Pecls using pecl
###################	
	$php_pecls = ["$pecl_rrd","$pecl_yaml","$pecl_ssh2",]
	package {$php_pecls:
		ensure => present,
		provider => pecl
	}
################
	#Make sure that the http pecl is less than version 2
	package {'Pecl http':
		name => $pecl_http,
		ensure => "1.7.6",
		provider => pecl
	}
	#Python system packages
	package {$python_dev:
		ensure => present

	}
	package {$python_libevent:
		ensure => present
	}
	package {$python_pip:
		ensure => present,
	}

	#Python packages using pip	
	package {'Python rrdtool':
		name => $python_rrdtool,
		ensure => present,
		provider => pip
	}
	package {'Python M2Crypto':
		name => $python_m2crypto,
		ensure => present,
		provider => pip,
	}
	#Python snmp bindings and the related packages
	package {'Snmp and also Python bindings':
		name => $python_snmp,
		ensure => present,
	}
	package {'Snmp base':
		name => $snmp_base,
	ensure => present,
	}
	package {'snmp15 package':
		name => $snmp15,
	ensure => present,
	}
	package {'Snmp package':
		name => $snmp,
	ensure => present,
	}
	#Ensure  upto date SNMP MIBS
	package {'snmp mibs':
		name => $snmp_mibs,
		ensure => latest,
	}

	#Get the latest source scalr(download) to the install_directory
	#Directory to have the scalr install
	file {'The install location for Scalr':
		path => $scalr_install_dir,
		ensure => directory,
		owner => $service_user,
		group => $scalr_group,
		#Get the service user to this class later 
	}

	exec {'download the scalr source':
		command => "wget ${scalr_source_url}",
		creates => "${scalr_install_dir}/${scalr_source_url}/",
		timeout => 0,
		require => File[$scalr_install_dir],
	}
	#Extract the scalr tar.gz downloaded
	-> exec {'Extract the scalr tar.gz':
		command => "tar zxvf ${scalr_tar_target} -C ${scalr_install_dir}",
		creates => "${scalr_install_dir}/phpunit.xml",
	}
	#Installing the scalr 
	-> exec {'Instaling scalrPy':
		command => "python setup.py build && python setup.py install",
		cwd => "${scalr_install_dir}/app/python",
	}
	#Give ownership to the scalr/ directory to the scalr user

	#Give ownership to the scalr/app/www to www-data
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
	package {$apache:
		name => $apache,
		ensure => present
	}
	package {"Cron jobs":
		name => $cron,
		ensure => present
	}

}
