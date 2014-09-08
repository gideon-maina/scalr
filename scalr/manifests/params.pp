# /etc/puppet/modules/scalr/manifests/params.pp
# All the necessary parameters to be used by the scalr instance

class scalr::params {
	#The general parameters that are general to all the Operating systems families
	$service_user = '',
	$web_user = 'www-data',
	$scalr_group = '',
	$scalr_install = '',
	$scalr_errorlog = '/var/log/scalr-error.log',
	$scalr_accesslog = '/var/log/scalr-access.log',
	$message_sender_pidfile = '',
	$message_sender_logfile = '',
	$database_queue_pidfile = '',
	$database_queue_logfile = '',
	$plotter_pidfile = '',
	$plotter_logfile = '',
	$poller_pidfile = '',
	$poller_logfile = '',
	$scalarizr_pidfile = '',
	$scalarizr_logfile = '',

}


