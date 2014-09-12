#The main class for the Scalr instance as the entry point for the 
#scalr module and integration with the other classes

<<<<<<< HEAD
class scalr{
		class {'::scalr::params':}->
		class {'::scalr::install':}->
		class {'::scalr::users':}->
		class {'::scalr::config':}->
		class {'::scalr::services':}->
			
		Class[scalr]	
=======

class scalr{
	
>>>>>>> 621a7b7c76a6d3309ca25213688c338920753a1e
}