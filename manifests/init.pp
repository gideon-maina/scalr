#The main class for the Scalr instance as the entry point for the 
#scalr module and integration with the other classes

class scalr (
$service_user = $scalr::params::service_user,
)  inherits scalr::params{
	 
		class {'::scalr::users':} 
		class {'::scalr::install':}  		 
		class {'::scalr::config':} #~>
		class {'::scalr::services':} 
			
		#Class[scalr]	
}
