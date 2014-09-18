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
	context 'the required directories for scalr' do
		it { should contain_file('/opt/scalr/').with_ensure('directory')}
	end
	context 'Checking all the execs in the install class' do 
		it { should contain_exec('download the scalr source').with_command('wget https://github.com/Scalr/scalr/archive/v4.5.1.tar.gz -O /tmp/scalr.tar.gz')}
		it { should contain_exec('download the scalr source').that_requires('File[/opt/scalr/]') }
		it { should contain_exec('download the scalr source').with_creates('/tmp/scalr.tar.gz') }
		it { should contain_exec('Extract the scalr tar.gz').with_command('tar zxvf /tmp/scalr.tar.gz -C /opt/scalr/')}
		it { should contain_exec('Extract the scalr tar.gz').with_creates('/opt/scalr/phpunit.xml')}
		it { should contain_exec('Instaling scalrPy').with_command('python setup.py build && python setup.py install')}
		it { should contain_exec('Instaling scalrPy').with_cwd('/opt/scalr/app/python')}

	end
end