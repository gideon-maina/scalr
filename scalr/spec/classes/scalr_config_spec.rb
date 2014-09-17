#To get the configuration testing in this class for the 
# config class 

require 'spec_helper'

describe "scalr::config" do 
	context 'The configuration for the php ini configuration' do
		it { should contain_file('/etc/apache2/apache2.conf').with_ensure('file') }
    end
    context 'The scalr cache directory' do
    	it { should contain_file('/opt/scalr/cache').with_ensure('directory')}
    end

    context 'The scalr graphics directory' do
    	it { should contain_file('/opt/scalr/graphics').with_ensure('directory')}
    end
    context 'The data directories' do 
    	it { should contain_file('/var/lib/rrdcached/db/x1x6').with_ensure('directory')}
    end
end 	 	