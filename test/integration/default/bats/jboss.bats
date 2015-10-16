#!/usr/bin/env bats

@test "java is found in PATH" {
  run which java
  [ "$status" -eq 0 ]
}

@test "jboss process is visible " {
  result=$(ps aux | grep java | grep jboss|wc -l)
  [ "$result" -eq 1 ]
}

@test "war is placed in proper location " {
  run [ -f node['TestRepo']['jboss_home']/standalone/deployments/testweb.war ]
  [ "$status" -eq 0 ]
}


@test "war is unrolled" {
  run [ -d #{node['TestRepo']['jboss_home']}/standalone/deployments/testweb ]
  [ "$status" -eq 0 ]
}