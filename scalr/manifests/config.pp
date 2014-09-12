#This class configures all the necessary needs for configuration of the components needed by scalr.

class scalr::config (
#Declare the parameters from params class
$service_user = $scalr::params::service_user,
$web_user = $scalr::params::web_server,
$super_user = $scalr::params::super_user,
$scalr_group = $scalr::params::scalr_group,

$scalr_install_dir = $scalr::params::scalr_install_dir,
$scalr_errorlog = $scalr::params::scalr_errorlog,
$scalr_accesslog = $scalr::params::scalr_accesslog,
$message_sender_pidfile = $scalr::params::message_sender_pidfile,
$message_sender_logfile = $scalr::params::message_sender_logfile,
$database_queue_pidfile = $scalr::params::database_queue_pidfile,
$database_queue_logfile = $scalr::params::database_queue_logfile,
$plotter_pidfile = $scalr::params::plotter_pidfile,
$plotter_logfile = $scalr::params::plotter_logfile,
$poller_pidfile = $scalr::params::poller_pidfile,
$poller_logfile = $scalr::params::poller_logfile,
$scalarizr_pidfile = $scalr::params::scalarizr_pidfile,
$scalarizr_logfile = $scalr::params::scalarizr_logfile,
$module_name = $scalr::params::module_name,
$rrd_config = '',
scalr_new_config = '',

)
inherits scalr::params {
	#Global settings
	Exec { 
		path => [ "/bin/","/usr/bin", "/usr/local/sbin/" , "/usr/local/bin/" ] 
	}
	#Php configuration and also 
	#Ensuring that apache2 and cli SAPI's are affected 
	#This will involve invoking with php5_invoke to reflect cli and apache2 sapis
	file {"PHP ini file with necessary changes":
		path => $php_ini,
		ensure => file,
		content => template($php_ini_template),
	}
	#Take care of SELinux unpacked directory to be accessible via the web server

	#Configure the MySQL Scalr database user password and feed it with sql.

	#Configure the MySQL ScalCost_Analytics password and feed it with sql.

	#Set MySQL timezone Php time zone

	#Create the cache folder for Scalr
	file {"cache folder inside scalr/app/":
			path => "${scalr_install_dir}/${scalr_cache_folder}/",
			ensure => directory,
			mode => 0770,
			owner => $service_user,
			group => $scalr_group,
	}
	#Configure rrdcached by modifying /etc/default/rrdcached(restart the rrdcached service)
	#Use augeas for the addition into the file 
	augeas {"Modifying the file /etc/default/rrdcached":
			context => $rrd_config,
			changes => [PTS="-s ${scalr_group}"
						OPTS="\$OPTS -l unix:/var/run/rrdcached.sock"
						OPTS="\$OPTS -j /var/lib/rrdcached/journal/ -F"
						OPTS="\$OPTS -b /var/lib/rrdcached/db/ -B"],
			#need to refresh the rrdcached service after changes
	}
	#Create the required graph directory
	file {"Graph directories":
			path => "${scalr_install_dir}/${graphics_dir}",
			ensure => directory,
			owner => $service_user,
			group => $scalr_group,
			mode => 0755,
	}
	#For raw data
	$raw_data_dirs = []
	file {$raw_data_dirs:
			ensure => directory,
			mode => 0755,
			owner => $service_user,
			group => $scalr_group,
	}

	#Configure the Apache2 web server Virtualhost 
	file {"Apache2 Virtualhost":
			path => $apache2_config,
			ensure => file,
			content => template($apache_virtual_host.erb),
	}
	#Setting the configuration templates
	exec {"Copying the scalr config to the working dir":
			command => "cp ${scalr_install_dir}/${scalr_original_config ${scalr_install_dir}/${scalr_new_config} ",
			creates => "{scalr_install_dir}/${scalr_new_config}",
	}
	#Run the database migrations

	#Configure the scalr Cron jobs for the scalr instance(php cron jobs)

	#Configure the scalr daemons
	#1 Message sender

	#2 Database queue processor

	#3 Load statistics Plotter

	#4 Load statistics Poller

	#5 Scalarizr Update service

	#Navigate and validate the installation
	#executing php test environment.php


}