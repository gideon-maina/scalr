#Tis class will makke sure that all the dependencies are installed and met.

class scalr::install  (
#Declare the parameters to be used from the parameters class
$php             = $scalr::params::php,
$php_sockets     = $scalr::params::php_sockets,
$php_gettext     = $scalr::params::php_gettext,
$php_mcrypt      = $scalr::params::php_mcrypt,
$php_plain       = $scalr::params::php_plain,
$php_libmagic         = $scalr::params::php_libmagic,
#$php_soap        = $scalr::params::php_soap,
$php_mysqli      = $scalr::params::php_mysqli,
$libapache2_mod_php5 = $scalr::params::libapache2_mod_php5,
$php_snmp        = $scalr::params::php_snmp,
$php_curl        = $scalr::params::php_curl,
$php_ldap        = $scalr::params::php_ldap,
$python_dev      = $scalr::params::python_dev,
$python_libevent = $scalr::params::python_libevent,
$python_pip      = $scalr::params::python_pip,
$python_rrdtool  = $scalr::params::python_rrdtool,
$pecl_http       = $scalr::params::pecl_http,
$pecl_rrd        = $scalr::params::pecl_rrd,
$pecl_yaml       = $scalr::params::pecl_yaml,
$pecl_ssh2       = $scalr::params::pecl_ssh2,
$snmp_mibs       = $scalr::params::snmp_mibs,
$rrdtool         = $scalr::params::rrdtool,
$rrdcached       = $scalr::params::rrdcached,
$apache          = $scalr::params::apache,
$cron            = $scalr::params::cron,
$python_m2crypto = $scalr::params::python_m2crypto,
$python_snmp     = $scalr::params::python_snmp,
$snmp_base       = $scalr::params::snmp_base,
$snmp15          = $scalr::params::snmp15,
$snmp            = $scalr::params::snmp,
$scalr_version   = $scalr::params::scalr_version,
$scalr_source_url  = $scalr::params::scalr_source_url,
$scalr_install_dir = $scalr::params::scalr_install_dir,
$scalr_tar_target  = $scalr::params::scalr_tar_target
) 

inherits scalr::params {
	# Global setttings
	Exec { 
		path => [ "/bin/","/usr/bin", "/usr/local/sbin/" , "/usr/local/bin/","/usr/sbin/", ] 
	}
	#Php dependencies using system package manager
	#Php extensions using system package manager
	$php_packages = [$php,$php_plain,$php_gettext,$php_mcrypt,$php_libmagic,$php_mysqli,$php_snmp,$php_curl,$php_ldap,]
	
        package {$php_packages:
		ensure => latest,
	}
	#apache libapache2 
	package {"${libapache2_mod_php5}":
		#name => $libapache2_mod_php5,
		ensure => present,
	}

	#Php Pecls using pecl
	#Php Pecls using pecl
        package {'php-pear':
               ensure => present,
        }
	package {"libcurl3":
        ensure => present,
        }
        package {"libcurl4-gnutls-dev":
        ensure => present,
        }
        package {"librrd-dev":
        ensure => present,
        }
        package {"libyaml-dev":
        ensure => present,
        }
        package {"libssh2-1-dev":
        ensure => present,
        }
        exec {"pecl install ${pecl_rrd}":
              timeout => 0,
              require => Package['php-pear'],
        }
	exec {"enable mcrypt":
	      command => "php5enmod mcrypt",		
	}
	file {"pecl rrd":
	path => "/etc/php5/mods-available/rrd.ini",
	content => "extension=rrd.so"
	}
	  exec {"enable rrd": 
                command => "php5enmod rrd",
		require => File['pecl rrd'],
        }
	
        exec {"pecl install ${pecl_yaml}":
               timeout => 0,
               require => Package['php-pear'],
        }

	file {"pecl yaml":
	path => "/etc/php5/mods-available/yaml.ini",
	content => "extension=yaml.so"
	}
	exec {"enable yaml":
                command => "php5enmod yaml",
                require => File['pecl yaml'],
        }
         exec {"pecl install ${pecl_ssh2}":
               timeout => 0,
               require => Package['php-pear'],
        }

	file {"pecl ssh2":
	path => "/etc/php5/mods-available/ssh2.ini",
	content => "extension=ssh2.so"
	}
        
	exec {"enable ssh2":
                command => "php5enmod ssh2",
                require => File['pecl ssh2'],
        }
        #Make sure that the http pecl is less than version 2 1.7.6
        exec {"pecl install ${pecl_http}":
        }

	file {"pecl http":
	path => "/etc/php5/mods-available/http.ini",
	content => "extension=http.so",
	}
	
	exec {"enable http":
                command => "php5enmod http",
                require => File['pecl http'],
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
		name     => $python_rrdtool,
		ensure   => present,
		#provider => pip
	}
	package {'Python M2Crypto':
		name     => $python_m2crypto,
		ensure   => present,
		provider => pip,
	}
	#Python snmp bindings and the related packages
	package {'Snmp and also Python bindings':
		name   => $python_snmp,
		ensure => present,
	}
	package {'Snmp base':
		name   => $snmp_base,
     	ensure => present,
	}
	package {'snmp15 package':
		name   => $snmp15,
	    ensure => present,
	}
	package {'Snmp package':
		name   => $snmp,
	    ensure => present,
	}
	#Ensure  upto date SNMP MIBS
	#for debian based systems
	#exec {'download the snmp.deb':
	#	command => "wget ${snmp_mibs} -O /tmp/snmp.deb",
	#	creates => "/tmp/snmp.deb",	       
	#}
	package {'snmp-mibs-downloader dependency':
		name  => "smistrip",
		ensure => present,
	}
	package {'snmp mibs downloader':
		ensure => present,
		#name => $snmp_mibs,
		#source   => "/tmp/snmp.deb",
		#provider => dpkg,
		#require  => exec['download the snmp.deb'],
		#require  => package['snmp-mibs-downloader dependency'],
	}

	#Get the latest source scalr(download) to the install_directory
	#Directory to have the scalr install
	file { $scalr_install_dir:
		ensure => directory,
		owner  => 'www-data',
		group  => $scalr_group,
		#recurse => true,
		#Get the service user to this class later 
		#require => User[scalr::users::$service_user],
	}

	exec {'download the scalr source':
		command => "wget ${scalr_source_url} -O ${scalr_tar_target}",
		creates => "${scalr_tar_target}",
		timeout => 0,
		require => File[$scalr_install_dir],
	}
	#Extract the scalr tar.gz downloaded
	-> exec {'Extract the scalr tar.gz':
		command => "tar zxvf ${scalr_tar_target} -C ${scalr_install_dir}",
		creates => "${scalr_install_dir}scalr-${scalr_version}",
	}
	#Installing the scalr 
	-> exec {'Instaling scalrPy':
		command => "python setup.py build && python setup.py install",
		cwd     => "${scalr_install_dir}scalr-${scalr_version}/app/python",
	}
	#Give ownership to the scalr/ directory to the scalr user

	#Give ownership to the scalr/app/www to www-data
	file {"Give permissions to /app/www to www-data":
		path => "${scalr_install_dir}scalr-${scalr_version}/app/www",
		owner => 'www-data',
		recurse => true,
	}
	#Install Mysql 

	#Install rrdtool,rrdcached using using system package manager
	package {'rrdtool':
		name   => $rrdtool,
		ensure => present
	}
	package {'rrdcached':
		name   => $rrdcached,
		ensure => present
	}
	#Install Apache2 Web server using system package manager
	package {$apache:
		ensure => present
	}
	package {"Cron jobs":
		name   => $cron,
		ensure => present
	}

}

