class Chef::Resource::DroneConfig < Chef::Resource::LWRPBase
  provides :drone_config
  actions(:create, :delete)
  default_action(:create)

  attribute(:config_filepath,
            kind_of: String,
            name_attribute: true,
            required: true,
            cannot_be: :empty)
  attribute(:instance_name,
            kind_of: String,
            required: true,
            default: lazy { },
            cannot_be: :empty)
end
