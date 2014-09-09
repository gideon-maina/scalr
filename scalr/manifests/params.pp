# All the necessary parameters to be used by the scalr instance

class scalr::params {
	#The general parameters that are general to all the Operating systems families

	$service_user = '',
	$web_user = 'www-data',
	$super_user = 'root',
	$scalr_group = '',

	$scalr_install_dir = '',
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
	
	$module_name = 'scalr',
	$module_version = '1',

	#The software package names for the platforms

	case operatingsystem ? {
	ubuntu, debian:{
		$php = '',
		$php_sockets = '',
		$php_gettext = '',
		$php_mcrypt = '',
		$php_hash = '',
		$php_pcntl = '',
		$php_posix ='',
		$php_dom = '',
		$php_soap = '',
		$php_snmp = '',
		$php_mysqli = '',
		$php_curl = '',
		$php_sem = '',
		$php_ldap = '',
		$php_pecl = '',
		$python_dev = '',
		$python_lebevent = '',
		$python_pip = '',
		$snmp_mibs = '',
		$rrdtool = '',
		$rrddcached = '',
		$apache = '',
		$cron = '',

	}
	centos:{
		$php = '',
		$php_sockets = '',
		$php_gettext = '',
		$php_mcrypt = '',
		$php_hash = '',
		$php_pcntl = '',
		$php_posix ='',
		$php_dom = '',
		$php_soap = '',
		$php_snmp = '',
		$php_mysqli = '',
		$php_curl = '',
		$php_sem = '',
		$php_ldap = '',
		$php_pecl = '',
		$python_dev = '',
		$python_lebevent = '',
		$python_pip = '',
		$snmp_mibs = '',
		$rrdtool = '',
		$rrddcached = '',
		$apache = '',
		$cron ='',
	}
	redhat:{
		$php = '',
		$php_sockets = '',
		$php_gettext = '',
		$php_mcrypt = '',
		$php_hash = '',
		$php_pcntl = '',
		$php_posix ='',
		$php_dom = '',
		$php_soap = '',
		$php_snmp = '',
		$php_mysqli = '',
		$php_curl = '',
		$php_sem = '',
		$php_ldap = '',
		$php_pecl = '',
		$python_dev = '',
		$python_lebevent = '',
		$python_pip = '',
		$snmp_mibs = '',
		$rrdtool = '',
		$rrddcached = '',
		$apache = '',
		$cron = '',
	}
	default: {
		$php = '',
		$php_sockets = '',
		$php_gettext = '',
		$php_mcrypt = '',
		$php_hash = '',
		$php_pcntl = '',
		$php_posix ='',
		$php_dom = '',
		$php_soap = '',
		$php_snmp = '',
		$php_mysqli = '',
		$php_curl = '',
		$php_sem = '',
		$php_ldap = '',
		$php_pecl = '',
		$python_dev = '',
		$python_lebevent = '',
		$python_pip = '',
		$snmp_mibs = '',
		$rrdtool = '',
		$rrddcached = '',
		$apache = '',
		$cron = '',
	}
  }#End case statement

#Other general parameters that are needed by the scalr instance

	$timezone = '',
	$scalr_code_url = '',
	$mysql_user = '',
	$mysql_password = '',
	$mysql_scalr_database = '',
	$mysql_scalr_cost_analytics = '',
	$mysql_timezone = '',

	$graphics_dir = '$scalr_install/app/www/graphics',
	$data_dir1 = '/var/lib/rrdcached/db/x1x6',
	$data_dir2 = '/var/lib/rrdcached/db/x2x7',
	$data_dir3 = '/var/lib/rrdcached/db/x3x8',
	$data_dir4 = '/var/lib/rrdcached/db/x4x9',
	$data_dir5 = '/var/lib/rrdcached/db/x5x0',


}


