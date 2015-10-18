#
# Cookbook Name:: TestRepo
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java_se'
include_recipe 'apt'

user node['TestRepo']['jboss_user'] do |variable|
	home node['TestRepo']['jboss_home']
	system true
 	shell '/bin/false'
end

group node['TestRepo']['jboss_user'] do
  members node['TestRepo']['jboss_user'] 
  action :modify
end

ark 'jboss' do |variable|
	url node['TestRepo']['jboss_downl_url']
	home_dir node['TestRepo']['jboss_home']
	owner node['TestRepo']['jboss_user']
	group node['TestRepo']['jboss_user']
	prefix_root node['TestRepo']['jboss_path']
		
end

# ark 'testweb' do |variable|
# 	url node['TestRepo']['web_app_url']
# 	path "#{node['TestRepo']['jboss_home']}/standalone/deployments/web"
# 	owner node['TestRepo']['jboss_user']
# 	action :put	
# end

cookbook_file "#{node['TestRepo']['jboss_home']}/standalone/deployments/testweb.war" do
  source "testweb.war"
  mode 00744
  owner node['TestRepo']['jboss_user']
  group node['TestRepo']['jboss_user']
end

cookbook_file "#{node['TestRepo']['jboss_home']}/standalone/deployments/testweb.xml" do
  source "testweb.xml"
  mode 00744
  owner node['TestRepo']['jboss_user']
  group node['TestRepo']['jboss_user']
end

service 'jboss' do
  supports :start => true, :status => true, :stop => true
  start_command "sudo -u #{node['TestRepo']['jboss_user']} sh #{node['TestRepo']['jboss_home']}/bin/standalone.sh -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0"
  stop_command "#sudo -u #{node['TestRepo']['jboss_user']} sh #{node['TestRepo']['jboss_home']}/bin/jboss-admin.sh --connect command=:shutdown "
  # status_command ""
  action :start 
end

# service 'jboss' do
#   supports :start => true, :status => true, :stop => true, :restart => true
#   start_command "sudo sh #{node['TestRepo']['jboss_home']}/init.d/jboss-as-standalone.sh -start"
#   stop_command "sudo -u #{node['TestRepo']['jboss_user']} sh #{node['TestRepo']['jboss_home']}/init.d/jboss-as-standalone.sh -stop"
#   restart_command "sudo -u #{node['TestRepo']['jboss_user']} sh #{node['TestRepo']['jboss_home']}/init.d/jboss-as-standalone.sh -restart"
#   status_command "sudo -u #{node['TestRepo']['jboss_user']} sh #{node['TestRepo']['jboss_home']}/init.d/jboss-as-standalone.sh -status"
#   action :start 
# end