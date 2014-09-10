# All the necessary parameters to be used by the scalr instance

class scalr::params {
	#The general parameters that are general to all the Operating systems families

	$service_user = 'scalr'
	$web_user = 'www-data'
	$super_user = 'root'
	$scalr_group = 'scalr'

	$scalr_source_url = 'https://github.com/Scalr/scalr/archive/v4.5.1.tar.gz'
	#Would like the version given as a user input
	
	$scalr_install_dir = '/opt/scalr/'
	$scalr_errorlog = '/var/log/scalr-error.log'
	$scalr_accesslog = '/var/log/scalr-access.log'
	$message_sender_pidfile = ''
	$message_sender_logfile = ''
	$database_queue_pidfile = ''
	$database_queue_logfile = ''
	$plotter_pidfile = ''
	$plotter_logfile = ''
	$poller_pidfile = ''
	$poller_logfile = ''
	$scalarizr_pidfile = ''
	$scalarizr_logfile = ''
	
	$module_name = 'scalr'
	$module_version = '1'

	#The scalr source url

	#The software package names for the distros

	case operatingsystem ? {
	ubuntu debian:{
		$php = 'php5-dev'
		$php_sockets = 'php-net-socket'
		$php_gettext = 'php-gettext'
		$php_mcrypt = 'php5-mcrypt'
		$php_hash = ''
		$php_pcntl = ''
		$php_posix =''
		$php_dom = ''
		$php_soap = ''
		$php_snmp = 'php5-snmp'
		$php_mysqli = ''
		$php_curl = 'php5-curl'
		$php_sem = ''
		$php_ldap = 'php5-ldap'
		$php_pecl = ''
		$python_dev = 'python-dev'
		$python_libevent = 'libevent-dev'
		$python_pip = 'python-setuptools'
		$snmp_mibs = 'snmp-mibs-downloader package'
		$rrdtool = 'rrdtool'
		$rrddcached = 'rrdcached'
		$apache = 'apache2'
		$cron = 'cron'

	}
	centos:{
		$php = 'php55w'
		$php_sockets = '$php55w-common'
		$php_gettext = ''
		$php_mcrypt = 'php55w-mcrypt'
		$php_hash = ''
		$php_pcntl = 'php55w-cli'
		$php_posix = 'php55w-process'
		$php_dom = 'php55w-xml'
		$php_soap = 'php55w-soap'
		$php_snmp = 'php55w-snmp'
		$php_mysqli = 'php55w-mysqlnd'
		$php_curl = ''
		$php_sem = ''
		$php_ldap = 'php55w-ldap'
		$php_pecl = ''
		$python_dev = ''
		$python_lebevent = ''
		$python_pip = ''
		$snmp_mibs = ''
		$rrdtool = 'rrdtool'
		$rrddcached = 'rrdcached'
		$apache = ''
		$cron =''
	}
	redhat:{
		$php = ''
		$php_sockets = ''
		$php_gettext = ''
		$php_mcrypt = ''
		$php_hash = ''
		$php_pcntl = ''
		$php_posix =''
		$php_dom = ''
		$php_soap = ''
		$php_snmp = ''
		$php_mysqli = ''
		$php_curl = ''
		$php_sem = ''
		$php_ldap = ''
		$php_pecl = ''
		$python_dev = ''
		$python_lebevent = ''
		$python_pip = ''
		$snmp_mibs = ''
		$rrdtool = ''
		$rrddcached = ''
		$apache = ''
		$cron = ''
	}
	default: {
		$php = 'php5-dev'
		$php_sockets = 'php-net-socket'
		$php_gettext = 'php-gettext'
		$php_mcrypt = 'php5-mcrypt'
		$php_hash = ''
		$php_pcntl = ''
		$php_posix =''
		$php_dom = ''
		$php_soap = ''
		$php_snmp = 'php5-snmp'
		$php_mysqli = ''
		$php_curl = 'php5-curl'
		$php_sem = ''
		$php_ldap = 'php5-ldap'
		$php_pecl = ''
		$python_dev = 'python-dev'
		$python_libevent = 'libevent-dev'
		$python_pip = 'python-setuptools'
		$snmp_mibs = 'snmp-mibs-downloader package'
		$rrdtool = 'rrdtool'
		$rrddcached = 'rrdcached'
		$apache = 'apache2'
		$cron = 'cron'
	}
  }#End case statement

#Other general parameters that are needed by the scalr instance

	$timezone = 'UTC'	
	$mysql_user = 'scalr'
	$mysql_password = 'Thepassword'
	$mysql_scalr_database = 'scalr'
	$mysql_scalr_cost_analytics = scalr_analytics''
	$mysql_timezone = 'UTC'

	$graphics_dir = '$scalr_install_dir/app/www/graphics'
	$data_dir1 = '/var/lib/rrdcached/db/x1x6'
	$data_dir2 = '/var/lib/rrdcached/db/x2x7'
	$data_dir3 = '/var/lib/rrdcached/db/x3x8'
	$data_dir4 = '/var/lib/rrdcached/db/x4x9'
	$data_dir5 = '/var/lib/rrdcached/db/x5x0'


}

