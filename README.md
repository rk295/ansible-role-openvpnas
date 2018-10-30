# Ansible role: openvpn as configure

[![Build Status](https://travis-ci.org/rk295/ansible-role-openvpnas.svg?branch=master)](https://travis-ci.org/rk295/ansible-role-openvpnas)

This role enables idempotent configuration of the [OpenVPN Access Server] via the vendor provided [sacli] utility.

Currently it supports all the keys available via the `ConfigPut` option to `sacli`, but none of the other configurable items. Any PR's adding extra functionality will be welcomed.

## Details

To ensure we don't run all the tasks every time Ansible runs, we deploy a simple idempotent wrapper `files/config-set` to the host on the first run (this uses jq, which the role will install). This script checks the current `value` for a given `key` only setting a new `value` if it differs from the current configuration.

The full list of options to `ConfigPut` is held in a list of maps in `vars/main.yml`, this enables Ansible friendly variable names to be used, these being looked up in that map at run time. If you find an option I've missed, or one that lacks documentation in the [Variables](#variables) section below, please feel free to submit a PR.

## Requirements

Currently it is intended to be run against the OpenVPN AS Appliance as provided by OpenVPN on the AWS Marketplace. Any PRs which add support for a manually installed instance of OpenVPN AS are welcome.

## Variables

**Note**: It is expected the SSL cert and key will be provided via an [Ansible Vault] or similar.

All of this section are passed verbatim through to `sacli`.

* `admin_ui_https_ip_address` - 
* `admin_ui_https_port` - 
* `aui_eula_version` - 
* `auth_ldap_0_bind_dn` - Username to connect to (eg: `administrator@ldap.example.com`)
* `auth_ldap_0_bind_pw` - Password to connect with
* `auth_ldap_0_name` - Friendly name of the LDAP server
* `auth_ldap_0_server_0_host` - 1st LDAP server hostname
* `auth_ldap_0_server_1_host` - 2nd  LDAP server hostname
* `auth_ldap_0_ssl_verify` - Should SSL be enabled. Must be one of always', 'never', 'adaptive. Defaults to `always`.
* `auth_ldap_0_timeout` - 
* `auth_ldap_0_uname_attr` - The Username Attribute. This is often uid for generic LDAP servers and sAMAccountName for Active Directory LDAP servers.
* `auth_ldap_0_use_ssl` - Should SSL be enabled. Must be one of always', 'never', 'adaptive. Defaults to `always`.
* `auth_ldap_0_users_base_dn` - Search DN (eg: `cn=Users,dc=ldap,dc=example,dc=com`)
* `auth_module_type` - LDAP/Radiu/PAM
* `auth_pam_0_service` - 
* `auth_radius_0_acct_enable` - 
* `auth_radius_0_name` - 
* `cs_ca_bundle` - The CA Bundle to use for the web server
* `cs_cert` - The TLS Certificate to use for the web server
* `cs_cws_proto_v2` - 
* `cs_https_ip_address` - 
* `cs_https_port` - 
* `cs_priv_key` - The TLS Private key to use for the web server
* `cs_prof_sign_web` - 
* `host_name` - 
* `sa_initial_run_groups_0` - 
* `sa_initial_run_groups_1` - 
* `vpn_client_basic` - 
* `vpn_client_config_text` - 
* `vpn_client_routing_inter_client` - 
* `vpn_client_routing_reroute_dns` - 
* `vpn_client_routing_reroute_gw` - 
* `vpn_daemon_0_client_netmask_bits` - 
* `vpn_daemon_0_client_network` - 
* `vpn_daemon_0_listen_ip_address` - 
* `vpn_daemon_0_listen_port` - 
* `vpn_daemon_0_listen_protocol` - 
* `vpn_daemon_0_server_ip_address` - 
* `vpn_server_config_text` - 
* `vpn_server_daemon_enable` - 
* `vpn_server_daemon_tcp_n_daemons` - 
* `vpn_server_daemon_tcp_port` - 
* `vpn_server_daemon_udp_n_daemons` - 
* `vpn_server_daemon_udp_port` - 
* `vpn_server_group_pool_0` - 
* `vpn_server_nat_masquerade` - 
* `vpn_server_port_share_enable` - 
* `vpn_server_port_share_ip_address` - 
* `vpn_server_port_share_port` - 
* `vpn_server_port_share_service` - 
* `vpn_server_routing_private_access` - 
* `vpn_server_routing_private_network_0` - 
* `vpn_tls_refresh_do_reauth` - 
* `vpn_tls_refresh_interval` - 

## Dependencies

No dependencies

## Тesting roles

Require

* ruby 2.3
* gems managed by bundler

To install gem run

```sh
bundle install
```

To execute testing - run kitchen command under the same folder of .kitchen.yml (By default testing driver - EC2)

```sh
kitchen test
```

## Example Playbook

In the example below `certificate.yml` is an [Ansible Vault], contains the `cs_cert` and `cs_priv_key` variables.

```yaml
---
- hosts: openvpnas
  become: true
  vars:
    ldap_auth_ldap_0_namename: vpn.example.com
    ldap_auth_ldap_0_server_0_hostserver_0: ldap.example.com
    auth_ldap_0_bind_dn: administrator@ldap.example.com
    auth_ldap_0_bind_pw: superstrongpassword
    auth_ldap_0_users_base_dn: cn=Users,dc=ldap,dc=example,dc=com
    auth_ldap_0_uname_attr: sAMAccountName
    auth_ldap_0_use_ssl: always
    auth_module_type: ldap
  vars_files:
    - certificate.yml
  roles:
  - role: openvpnas
```

## Author Information

Robin Kearney <robin@kearney.co.uk>

[Ansible Vault]: https://docs.ansible.com/ansible/2.4/vault.html
[sacli]: https://docs.openvpn.net/command-line/
[OpenVPN Access Server]: https://openvpn.net/vpn-server/