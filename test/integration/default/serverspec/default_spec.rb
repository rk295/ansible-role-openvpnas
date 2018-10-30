require 'serverspec'

set :backend, :exec

# Test setup, grab the config once, saves time.
system('sudo /usr/local/openvpn_as/scripts/sacli ConfigQuery > /tmp/sacli.json')

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.module.type' => 'ldap') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.name' => 'vpn.example.com') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.server.0.host' => 'ldap.example.com') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.bind_dn' => 'administrator@ldap.example.com') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.bind_pw' => 'superstrongpassword') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.users_base_dn' => 'cn=Users,dc=ldap,dc=example,dc=com') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.uname_attr' => 'sAMAccountName') }
end

describe file('/tmp/sacli.json') do
  its(:content_as_json) { should include('auth.ldap.0.use_ssl' => 'always') }
end