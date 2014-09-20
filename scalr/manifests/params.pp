# All the necessary parameters to be used by the scalr instance

class scalr::params {
	#The general parameters that are general to all the Operating systems families
	$your_ip_public_dn	    = 'ec2-54-77-148-143.eu-west-1.compute.amazonaws.com'
	$service_user           = 'scalr'
	$web_user               = 'www-data'
	$super_user             = 'root'
	$scalr_group            = 'scalr'
	$user_group_provider    = 'ldap'
	$service_user_id        = 496
	$scalr_group_id         = 498
	#The above can be changed to pw useradd aix e.t.c

	$scalr_errorlog         = '/var/log/scalr-error.log'
	$scalr_accesslog        = '/var/log/scalr-access.log'
	$message_sender_pidfile = '/var/run/msg_sender.pid'
	$message_sender_logfile = '/var/log/msg_sender.log'
	$database_queue_pidfile = '/var/run/db_queue.pid'
	$database_queue_logfile = '/var/log/db_queue.log'
	$plotter_pidfile        = '/var/run/plotter.pid'
	$plotter_logfile        = '/var/log/plotter.log'
	$poller_pidfile         = '/var/run/poller.pid'
	$poller_logfile         = '/var/log/poller.log'
	$scalarizr_pidfile      = '/var/run/scalr.pid'
	$scalarizr_logfile      = '/var/log/scalr.log'
	
	#$module_name = 'scalr'
	$module_version         = '1'

	#The scalr source url
	$php_ini                 = '/tmp/php.ini'
	$php_ini_template        = 'php.ini.erb'
	$apache2_config_template = 'apache_virtual_host.erb'
	$apache2_service         = 'apache2'
	#The software package names for the distros
	case $::operatingsystem {
	'Ubuntu':{
		$php         = 'php5-dev'
		$php_plain   = 'php5'
		$php_sockets = 'php-net-socket'
		$php_gettext = 'php-gettext'
		$php_mcrypt  = 'php5-mcrypt'
		$php_snmp    = 'php5-snmp'
		$php_mysqli  = 'php5-mysql'
		$php_curl    = 'php5-curl'
                $php_libmagic= 'libmagic-dev'
		$php_ldap    = 'php5-ldap'
		$php_pecl    = 'php-pear'
		$python_dev  = 'python-dev'
		$python_libevent = 'libevent-dev'
		$python_pip  = 'python-pip'
		$python_snmp = 'libsnmp-python'
		$snmp_base   = 'libsnmp-base'
		$snmp15      = 'libsnmp30'# 15 can be replaced by  30
		$snmp        = 'snmp'
		#$snmp_mibs   = 'http://security.ubuntu.com/ubuntu/pool/multiverse/s/snmp-mibs-downloader/snmp-mibs-downloader_1.1_all.deb'
		$snmp_mibs   = 'snmp-mibs-downloader'
		$rrdtool     = 'rrdtool'
		$rrddcached  = 'rrdcached'
		$libapache2_mod_php5 = 'libapache2-mod-php5'
		$apache      = 'apache2'
		$apache2_config = '/etc/apache2/sites-available/scalr.conf'
		$cron        = 'cron'

	}
	centos:{
		$php            = 'php55w'
		$php_sockets    = '$php55w-common'
		$php_gettext    = ''
		$php_mcrypt     = 'php55w-mcrypt'
		$php_hash       = ''
		$php_pcntl      = 'php55w-cli'
		$php_posix      = 'php55w-process'
		$php_dom        = 'php55w-xml'
		$php_soap       = 'php55w-soap'
		$php_snmp       = 'php55w-snmp'
		$php_mysqli     = 'php55w-mysqlnd'
		$php_curl       = ''
		$php_sem        = ''
		$php_ldap       = 'php55w-ldap'
		$php_pecl       = ''
		$python_dev     = ''
		$python_lebevent = ''
		$python_pip     = ''
		$python_snmp    = 'libsnmp-python'
		$snmp_base      = 'libsnmp-base'
		$snmp15         = 'libsnmp30'#15 can be replaced by 30
		$snmp           = 'snmp'
		$snmp_mibs      = ''
		$rrdtool        = 'rrdtool'
		$rrddcached     = 'rrdcached'
		$apache         = ''
		$apache2_config = ''
		$cron           = 'cron'
	}
	#Assuming that the default will agree to the following otherwise can issue a notify
	#of no support for the distribution.
	default: {
		fail("Module not supporting your OS ${::operatingsystem}")
	}
  }#End case statement
  #General packages that are universal for distros e.g for pip or pecl
  	$python_rrdtool        = 'python-rrdtool'
	$pecl_http             = 'pecl_http-1.7.6'
	$pecl_rrd              = 'rrd'
	$pecl_yaml             = 'yaml'
	$pecl_ssh2             = 'ssh2-0.12'
  #Scalr install parameters
	$scalr_version         = '4.5.1'
  	$scalr_source_url      = 'https://github.com/Scalr/scalr/archive/v${scalr_version}.tar.gz'
  	$scalr_install_dir     = '/opt/scalr/'
  	$scalr_tar_target      = '/tmp/scalr.tar.gz'
  	$scalr_new_config      = 'app/etc/config.yml'
  	$scalr_original_config = 'app/etc/config.yml-sample'
#Would like the version given as a user input
	$rrd_config            = '/etc/default/rrdcached'
	$rrdcached_service     = 'rrdcached'
	$rrd_config_template   = 'rrdcached.scalr.erb'
#python M2crypto since pip is universal
	$python_m2crypto       = 'M2Crypto'

#The cron jobs for the scalr instance variables
	$cron_file             = "${scalr_install_dir}/crontab"
	$cron_scheduler        = "* * * * * php -q ${scalr_install_dir}app/cron/cron.php --Scheduler"
	$cron_usagestats       = "*/5 * * * *  php -q ${scalr_install_dir}app/cron/cron.php --UsageStatsPoller"
	$cron_scaling          = "*/2 * * * *  php -q ${scalr_install_dir}app/cron-ng/cron.php --Scaling"		
	$cron_szr_message      = "*/2 * * * *  php -q ${scalr_install_dir}app/cron/cron.php --SzrMessagingAll"
    $cron_messagebeforehostup    = "*/2 * * * * php -q ${scalr_install_dir}app/cron/cron.php --SzrMessagingBeforeHostUp"
    $cron_messageinit            = "*/2 * * * * php -q ${scalr_install_dir}app/cron/cron.php --SzrMessagingHostInit"
    $cron_messagehostup          = "*/2 * * * * php -q ${scalr_install_dir}app/cron/cron.php --SzrMessagingHostUp"
	$cron_bundletaskmgr          = "*/2 * * * * php -q ${scalr_install_dir}app/cron/cron.php --BundleTasksManager"
	$cron_metriccheck            = "*/15 * * * * php -q ${scalr_install_dir}app/cron-ng/cron.php --MetricCheck"
	$cron_poller                 = "*/2 * * * * php -q ${scalr_install_dir}app/cron-ng/cron.php --Poller"
	$cron_dnsmanagerpoll         = "* * * * * php -q ${scalr_install_dir}app/cron/cron.php --DNSManagerPoll"
	$cron_rotatelogs             = "17 5 * * * php -q ${scalr_install_dir}app/cron/cron.php --RotateLogs"
	$cron_ebsmanager             = "*/2 * * * * php -q ${scalr_install_dir}app/cron/cron.php --EBSManager"
	$cron_rolesqueue             = "*/20 * * * * php -q ${scalr_install_dir}app/cron/cron.php --RolesQueue"
	$cron_dbsrmaintain           = "*/5 * * * * php -q ${scalr_install_dir}app/cron-ng/cron.php --DbMsrMaintenance"
	$cron_leasemanger            = "*/20 * * * * php -q ${scalr_install_dir}app/cron-ng/cron.php --LeaseManager"
	$cron_serverterminate        = "*/1 * * * * php -q ${scalr_install_dir}app/cron-ng/cron.php --ServerTerminate"
	$cron_cloud_pricing          = "0 */12 * * * php -q ${scalr_install_dir}app/cron/cron.php --CloudPricing"
	$cron_analyticsnotifications = "0 1 * * * php -q ${scalr_install_dir}app/cron/cron.php --AnalyticsNotifications"
	$cron_analyticspoller        = "*/5  * * * * python -m scalrpy.analytics_poller -c ${scalr_install_dir}app/etc/config.yml --start"
	$cron_analyticsprocessing    = "7,37 * * * * python -m scalrpy.analytics_processing -c ${scalr_install_dir}app/etc/config.yml --start"

#The daemons to be run for the scalr install
	$messange_sender             = "python -m scalrpy.msg_sender -p ${message_sender_pidfile} -l ${message_sender_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --start"
	$database_queue              = "python -m scalrpy.dbqueue_event -p ${database_queue_pidfile} -l ${database_queue_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --start"
	$load_statistics_plotter     = "python -m scalrpy.load_statistics -p ${plotter_pidfile} -l ${plotter_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --plotter --start"
	$load_statistics_poller      = "python -m scalrpy.load_statistics -p ${poller_pidfile} -l ${poller_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --poller --start"
	$scalarizr_update            = "python -m scalrpy.szr_upd_service -p ${scalarizr_pidfile} -l ${scalarizr_logfile} -c ${scalr_install_dir}scalr-${scalr_version}/app/etc/config.yml --interval=120 --start"
#Other general parameters that are needed by the scalr instance

	$timezone                    = 'UTC'	
	$php_timezone                = 'UTC'
	$mysql_user                  = 'scalr'
	$mysql_password              = 'Thepassword'
	$mysql_scalr_database        = 'scalr'
	$mysql_scalr_cost_analytics  = 'scalr_analytics'
	$mysql_timezone              = 'UTC'

	$scalr_cache_folder          = 'cache'#put /scalr_install_dir/app/ where used
	$graphics_dir                = 'graphics'#put /scalr_install_dir/app/ where used
	$data_dir1                   = '/var/lib/rrdcached/db/x1x6'
	$data_dir2                   = '/var/lib/rrdcached/db/x2x7'
	$data_dir3                   = '/var/lib/rrdcached/db/x3x8'
	$data_dir4                   = '/var/lib/rrdcached/db/x4x9'
	$data_dir5                   = '/var/lib/rrdcached/db/x5x0'


}

