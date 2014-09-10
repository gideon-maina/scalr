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

)
inherits scalr::params {
	#Php configuration 

	#Take care of SELinux unpacked directory to be accessible via the web server

	#Ensuring that apache2 and cli SAPI's are affected 

	#Configure the MySQL Scalr database user password and feed it with sql.

	#Configure the MySQL ScalCost_Analytics password and feed it with sql.

	#Set MySQL timezone Php time zone

	#Create the cache folder for Scalr

	#Configure rrdcached by modifying /etc/default/rrdcached(restart the rrdcached service)

	#Create the required graph directories
	#For raw data
	#For generated graphs

	#Set proper properties for the above directories

	#Configure the Apache2 web server Virtualhost 

	#Setting the configuration templates

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