#The class to manage the users and groups to be used and needed for the scalr instance
#1 $service_user
#2 $web_user	
#3 $scalr_group
#4 $super_user

class scalr::users (
	$service_user = $scalr::params::service_user,
	$web_user = $scalr::params::web_user,
	$scalr_group = $scalr::params::scalr_group,
	$super_user = $scalr::params::super_user
) {
	#The following will ensure that the above users are present 
	
}