#To check the user logic in the user class
require 'spec_helper'

describe 'scalr::users' do 
	context 'scalr service user' do
		it { should contain_user('scalr').with_ensure('present') }
	end
	context 'the web server user www-data' do
		it { should contain_user('www-data').with_ensure('present') }
	end
	context 'The scalr group to have scalr user' do 
		it { should contain_group('scalr').with_ensure('present') }
	end
end