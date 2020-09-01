require 'tss'

resource_name :tss_credential
provides :tss_credential

property :name, String, name_property: true
property :username, String
property :password, String
property :tenant, String
property :query, String

action :read do
  begin
    server = Tss::Server.new({
        username: new_resource.username,
        password: new_resource.password,
        tenant: new_resource.tenant

    secret = Tss::Secret.fetch(server, new_resource.query)

    node.run_state[new_resource.name] = secret
  rescue Exception => e
    raise "Could not find credential matching query!"
  end
end