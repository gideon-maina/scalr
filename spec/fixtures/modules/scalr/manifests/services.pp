#The scalr class to run all necessary services for the scalr instance
# including
#1. Cron
#2. Apache 
#3. The scalr instance install Daemons
#4. The rrdcached
#5. 
class scalr::services(
  $apache2_service         = $scalr::params::apache2_service,
  $cron                    = $scalr::params::cron,
  $rrdcached_service       = $scalr::params::rrdcached_service,
)
 inherits scalr::params {
	$services = [$apache2_service, $cron, $rrdcached, ]

	service {$services:
	    ensure     => running,
	    enable     =>  true,
	    
        #hasrestart => true,
	}
}