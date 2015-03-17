	#The ruby file to checl for and manage
	#the Scalr instance inside the class
	require 'spec_helper'

	describe 'scalr::services' do 
		context 'The apache2 web service daemon' do
			it { should contain_service('apache2').with_ensure('running')}
		end
		context 'the cron service ' do 
			it { should contain_service('cron').with_ensure('running')}
		end

		context 'The number of the resources' do 
			it { should have_resource_count(3) }
		end
	end
