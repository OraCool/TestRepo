#
# Cookbook Name:: TestRepo
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java_se'

user node['TestRepo']['jboss_user'] do |variable|
	home node['TestRepo']['jboss_home']
	system true
 	shell '/bin/false'
end

ark 'jboss' do |variable|
	url node['TestRepo']['jboss_downl_url']
	home_dir node['TestRepo']['jboss_home']
	owner node['TestRepo']['jboss_user']
	prefix_root node['TestRepo']['jboss_path']
		
end
