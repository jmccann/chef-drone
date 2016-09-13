ChefSpec.define_matcher :docker_container

def create_docker_installation_tarball(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:docker_installation_tarball, :create, resource_name)
end

def delete_docker_installation_tarball(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:docker_installation_tarball, :delete, resource_name)
end
