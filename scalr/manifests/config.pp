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
$rrd_config = $scalr::params::rrd_config,
scalr_new_config = $scalr::params::scalr_new_config,
scalr_original_config = $scalr::params::scalr_original_config,
$apache2_config = $scalr::params::apache2_config,
$data_dir1 = $scalr::params::data_dir1,
$data_dir2 = $scalr::params::data_dir2,
$data_dir3 = $scalr::params::data_dir3,
$data_dir4 = $scalr::params::data_dir4,
$data_dir5 = $scalr::params::data_dir5,
$cron_scheduler  = $scalr::params::cron_scheduler,
$cron_usagestats = $scalr::params::cron_usagestats,
$cron_scaling = $scalr::params::cron_scaling,
$cron_szr_message = $scalr::params::cron_messagebeforehostup,
cron_messagebeforehostup = $scalr::params::cron_messagebeforehostup,
$cron_messageinit = $scalr::params::cron_messageinit,
$cron_messagehostup = $scalr::params::cron_messagehostup,
$cron_bundletaskmgr = $scalr::params::cron_bundletaskmgr,
$cron_metriccheck = $scalr::params::cron_metriccheck,
$cron_poller = $scalr::params::cron_poller,
$cron_dnsmanagerpoll = $scalr::params::cron_dnsmanagerpoll,
$cron_rotatelogs = $scalr::params::cron_rotatelogs,
$cron_ebsmanager = $scalr::params::cron_ebsmanager,
$cron_rolesqueue = $scalr::params::cron_rolesqueue,
$cron_dbsrmaintain = $scalr::params::cron_dbsrmaintain,
$cron_leasemanger = $scalr::params::cron_leasemanger,
$cron_serverterminate = $scalr::params::cron_serverterminate,
$cron_cloud_pricing = $scalr::params::cron_cloud_pricing,
$cron_analyticsnotifications = $scalr::params::cron_analyticsnotifications,
$cron_analyticspoller = $scalr::params::cron_analyticspoller,
$cron_analyticsprocessing = $scalr::params::cron_analyticsprocessing,
$messange_sender = $scalr::params::messange_sender,
$database_queue = $scalr::params::database_queue,
$load_statistics_plotter = $scalr::params::load_statistics_plotter,
$load_statistics_poller = $scalr::params::load_statistics_poller,
$scalarizr_update = $scalr::params::scalarizr_update,
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

	#Set MySQL timezone to Php time zone (i.e UTC)

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
			notify => Service['rrdcached'],
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
	$raw_data_dirs = [$data_dir1,$data_dir2,$data_dir3,$data_dir4,$data_dir5]
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
			command => "cp ${scalr_install_dir}/${scalr_original_config} ${scalr_install_dir}/${scalr_new_config}",
			creates => "{scalr_install_dir}/${scalr_new_config}",
	}
	#Run the database migrations
	exec {"Run the database migrations for scalr database":
			command =>,
	}
	#Configure the scalr Cron jobs for the scalr instance(php cron jobs)
	$all_cron_jobs = [$cron_scheduler,$cron_usagestats,$cron_scaling,$cron_szr_message,cron_messagebeforehostup,$cron_messageinit,$cron_messagehostup,$cron_bundletaskmgr,$cron_metriccheck,$cron_poller,$cron_dnsmanagerpoll,$cron_rotatelogs,$cron_ebsmanager,$cron_rolesqueue,$cron_dbsrmaintain,$cron_leasemanger,$cron_serverterminate,$cron_cloud_pricing,$cron_analyticsnotifications,$cron_analyticspoller,$cron_analyticsprocessing]	
	cron {"The Cron jobs  sseent to this resource as an array above":
		#Set cron timezone to UTC
		command => $all_cron_jobs,
		ensure => present,
		provider => crontab,
		user => $service_user,
		#target => ,
		#weekday => Monday,
	}

	#Configure the scalr daemons
	#Either combining them as shown or as velow separate
	$daemons = [$messange_sender,$database_queue,$load_statistics_plotter,$load_statistics_poller,$scalarizr_update]
	exec {$daemons:
		#Will take the command from the variable
	}
	#Single command for each set up 
	#1 Message sender
	#exec {"The message sender daemon":
	#	command => ,
	#}
	#2 Database queue processor

	#3 Load statistics Plotter

	#4 Load statistics Poller

	#5 Scalarizr Update service

	#Navigate and validate the installation
	#executing php test environment.php
	exec {"Check installation":
		command => "php test environment.php",
		cwd => "${scalr_install_dir}/app/www",
	}


}