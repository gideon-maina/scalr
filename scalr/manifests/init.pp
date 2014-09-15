#The main class for the Scalr instance as the entry point for the 
#scalr module and integration with the other classes

class scalr::init {
    class {'::scalr::params':}->
    class {'::scalr::install':}->
    class {'::scalr::users':}->
    class {'::scalr::config':}->
    class {'::scalr::services':}->
    Class[scalr]
}