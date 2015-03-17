#To get the configuration testing in this class for the 
# config class 

require 'spec_helper'

describe "scalr::config" do 
    context 'The apache2 file source' do
        it { should contain_file('/etc/apache2/apache2.conf').with_ensure('file') }
        #it { should contain_file('/etc/apache2/apache2.conf').with_content('scalr/php.ini.erb')}
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
    context 'copying the scalr configuration file' do
        it { should contain_exec('Copying the scalr config to the working dir').with_command('cp /opt/scalr/app/etc/config.yml-sample /opt/scalr/app/etc/config.yml')}
        it { should contain_exec('Copying the scalr config to the working dir').with_creates('/opt/scalr/app/etc/config.yml')}
    end
end 

describe 'scalr::config' do 
    let(:title) { 'Check installation'}
    #let(:params) { { :cwd => '/opt/scalr/app/www'} }

    it { should contain_exec('Check installation').with_command('php test environment.php')}

end