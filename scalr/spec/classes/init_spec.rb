# for the manifests/init.pp
require 'spec_helper'

describe "scalr::init" do 
	it { should create_class('scalr::config') }
end	