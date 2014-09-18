#The class to manage the users and groups to be used and needed for the scalr instance
#1 $service_user
#2 $web_user	
#3 $scalr_group
#4 $super_user

class scalr::users (
	$service_user         = $scalr::params::service_user,
	$web_user             = $scalr::params::web_user,
	$scalr_group          = $scalr::params::scalr_group,
	$super_user           = $scalr::params::super_user,
	$user_group_provider  = $scalr::params::user_provider,
	$service_user_id      = scalr::params::service_user_id,
	$scalr_group_id       = scalr::params::scalr_group_id
) 
inherits scalr::params {
	#The following will ensure that the above users are present 
	user {$service_user:
		ensure     => present,
		groups     => $scalr_group,
		uid        => $service_user_id,
		gid        => $scalr_group_id,
		password   => 'password',
	   #system     => true,
		provider   => $user_group_provider,
		require    => Group["Scalr group"],
	} 	
	user {$web_user:
		ensure    => present,
	}
	group {$scalr_group:
		ensure    => present,
		gid       => $scalr_group_id,
		#system   => true
		provider  => $user_group_provider,

	}

}
