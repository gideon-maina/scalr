#The scalr class to run all necessary services for the scalr instance
# including
#1. Cron
#2. Apache 
#3. The scalr instance install Daemons
#4. The rrdcached
#5. 
class scalr::services(
  $apache2_service         = $scalr::params::apache2_service,
  $msg_sender_service_file      = $scalr::params::msg_sender_service_file,
  $rrdcached_service       = $scalr::params::rrdcached_service,
  $message_sender_pidfile  = $scalr::params::message_sender_pidfile,
$message_sender_logfile  = $scalr::params::message_sender_logfile,
$database_queue_pidfile  = $scalr::params::database_queue_pidfile,
$database_queue_logfile  = $scalr::params::database_queue_logfile,
$plotter_pidfile         = $scalr::params::plotter_pidfile,
$plotter_logfile         = $scalr::params::plotter_logfile,
$poller_pidfile          = $scalr::params::poller_pidfile,
$poller_logfile          = $scalr::params::poller_logfile,
$scalarizr_pidfile       = $scalr::params::scalarizr_pidfile,
$scalarizr_logfile       = $scalr::params::scalarizr_logfile,
$scalr_version           = $scalr::params::scalr_version,
$scalr_install_dir       = $scalr::params::scalr_install_dir

)
 inherits scalr::params {
	# Global setttings
	Exec { 
		path => [ "/bin/","/usr/bin", "/usr/local/sbin/" , "/usr/local/bin/" ] 
	}

	$services = [$apache2_service, $rrdcached_service, ]

	#service {$services:
	 #   ensure     => running,
	  #  enable     =>  true,	    
          #hasrestart => true,
	#}
	exec {"Daemon for message sender":
		command => "python -m scalrpy.msg_sender -p ${message_sender_pidfile} -l ${message_sender_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --start &",
	}
	exec {"Daemon for db quue event":
		command => "python -m scalrpy.dbqueue_event -p ${database_queue_pidfile} -l ${database_queue_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --start &",
	}
	exec {"Daemon for load statistics plotter":
		command => "python -m scalrpy.load_statistics -p ${plotter_pidfile} -l ${plotter_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --plotter --start &",
	}
	exec {"Daemon for load statistics poller":
		command => "python -m scalrpy.load_statistics -p ${poller_pidfile} -l ${poller_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --poller --start &",
	}
	exec {"Daemon for szr update":
		 command => "python -m scalrpy.szr_upd_service -p ${scalarizr_pidfile} -l ${scalarizr_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --interval=120 --start &",
	}
}
