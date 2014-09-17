#The ruby test file to check the contents inside the install class in 
#the scalr module
require 'spec_helper'

describe 'scalr::install' do 
	context 'install php5 and all php dependencies' do
		it { should contain_package('php5-dev').with_ensure('present')}
		it { should contain_package('php5-mcrypt').with_ensure('present')}
	end
	context 'install python and all python dependencies' do 
		it { should contain_package('python-dev').with_ensure('present')}
		it { should contain_package('python-setuptools').with_ensure('present')}
	end
	#context 'install mysql and all its dependencies' do
	#	it { should contain_package('mysql-server5.5').with_ensure('present')}
	#end
	context 'install rrdtool and all dependencies' do
		it { should contain_package('rrdtool').with_ensure('present')}
	end
	context 'install rrdcached and all dependencies' do
		it { should contain_package('rrdcached').with_ensure('present')}
	end
	context 'install the apache2 web server' do 
		it { should contain_package('apache2').with_ensure('present')}
	end
end