# for the manifests/init.pp
require 'spec_helper'

describe "scalr::init" do
	it { should compile}
    it { should create_class('scalr::params') }
	it { should create_class('scalr::install') }
	it { should create_class('scalr::config') }
	it { should create_class('scalr::users') }
	it { should create_class('scalr::services') }
end


