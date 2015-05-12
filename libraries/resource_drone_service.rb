class Chef::Resource::DroneService < Chef::Resource::LWRPBase
  provides :drone_service
  actions(:create, :delete)
  default_action(:create)

  attribute(:service_name,
            kind_of: String,
            name_attribute: true,
            required: true,
            cannot_be: :empty)
end
