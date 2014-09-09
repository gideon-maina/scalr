#This class configures all the necessary needs for configuration of the components needed by scalr.

class scalr::config{
	#Php configuration 

	#Ensuring that apache2 and cli SAPI's are affected 

	#Configure the MySQL Scalr database user password and feed it with sql.

	#Configure the MySQL ScalCost_Analytics password and feed it with sql.

	#Set MySQL timezone Php time zone

	#Create the cache folder for Scalr

	#Configure rrdcached by modifying /etc/default/rrdcached(restart the rrdcached service)

	#Create the required graph directories
	#For raw data
	#For generated graphs

	#Set proper properties for the above directories

	#Configure the Apache2 web server Virtualhost 

	#Setting the configuration templates

	#Run the database migrations

	#Configure the scalr Cron jobs for the scalr instance(php cron jobs)

	#Configure the scalr daemons
	#1 Message sender

	#2 Database queue processor

	#3 Load statistics Plotter

	#4 Load statistics Poller

	#5 Scalarizr Update service

	#Navigate and validate the installation
	#executing php test environment.php

	
}
