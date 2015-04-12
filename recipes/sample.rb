include_recipe 'docker'

cookbook_file 'Dockerfile' do
  path '/tmp/Dockerfile'
  source 'sample-img/Dockerfile'
end

docker_image 'ubuntu' do
  tag 'sample'
  source '/tmp'
  action :build_if_missing
end

docker_container 'sample' do
  image 'ubuntu:sample'
  container_name 'sample'
  detach true
  port '5000:5000'
  env 'SETTINGS_FLAVOR=local'
  volume '/mnt/docker:/docker-storage'

  # image 'ubuntu:sample'
  # container_name 'sample'
  # command "/bin/echo 'Hello'"
  # detach true
  # hostname 'sample.example.com'
  # port '5000:5000'
  # volume '/mnt/docker:/docker-storage'
  # action :run
end

docker_container 'sample' do
  action :start
end

