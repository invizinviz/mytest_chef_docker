include_recipe 'docker'

remote_directory '/tmp/football_fans' do
  source 'football_fans'
end

docker_image 'andres/football_fans' do
  source '/tmp/football_fans'
  action :build_if_missing
  cmd_timeout 900
end

if `sudo docker ps -a | grep football_fans`.size > 0
  execute('stop container') { command "docker stop -t 60 football_fans" }
  execute('remove container') { command "docker rm -f football_fans" }
end

docker_container 'football_fans' do
  image 'andres/football_fans'
  container_name 'football_fans'
  detach true
  port '80:80'
  command '/etc/init.d/postgresql start'
  command '/sbin/my_init'
  action :run
end

