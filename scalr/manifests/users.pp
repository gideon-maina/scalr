#The class to manage the users and groups to be used and needed for the scalr instance
#1 $service_user
#2 $web_user	
#3 $scalr_group
#4 $super_user

class scalr::users (
	$service_user = $scalr::params::service_user,
	$web_user = $scalr::params::web_user,
	$scalr_group = $scalr::params::scalr_group,
<<<<<<< HEAD
	$super_user = $scalr::params::super_user,
	$user_group_provider = $scalr::params::user_provider,
	$service_user_id = scalr::params::service_user_id,
	$scalr_group_id = scalr::params::scalr_group_id
) 
inherits scalr::params {
	#The following will ensure that the above users are present 
	user {"The Scalr service_user":
		name => $service_user,
		ensure => present,
		group => $scalr_group,
		uid => $service_user_id,
		gid => $,
		password => '',
		#system => true,
		provider => $user_group_provider,
		require => Group[$scalr_group],
	} 	
	user {"The web server user www-data":
		name => $web_user,
		ensure => present,
	}
	group {"The scalr groups that scalr user belongs to": 
		name => $scalr_group,
		ensure => present,
		gid => $scalr_group_id,
		#system => true
		provider => $user_group_provider,

	}

=======
	$super_user = $scalr::params::super_user
) {
	#The following will ensure that the above users are present 
	
>>>>>>> 621a7b7c76a6d3309ca25213688c338920753a1e
}