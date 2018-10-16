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

describe file('/usr/local/openvpn_as/etc/web-ssl/server.crt') do
  its(:sha256sum) { should eq '0e46fe1b57d2251ee6d93fcd6c4b4b9106c0ef4be713e8f3e51a810600c7adc8' }
end

describe file('/usr/local/openvpn_as/etc/web-ssl/server.key') do
  its(:sha256sum) { should eq '0edbde21fe1ec89641ad8953a8952d1c2b8a888b8c472b9574aefa5d620271d2' }
end
