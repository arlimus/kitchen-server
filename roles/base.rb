name "base"
description "Basic work server configuration"
override_attributes({
  'network' => {
    'forwarding' => true
  },
  'authorization' => {
    'sudo' => {
      'groups' => %w{ admin sysadmin },
      'passwordless' => true
    }
  },
  'ssh' => {
    'allow_tcp_forwarding' => true,
    'allow_agent_forwarding' => true
  }
})

run_list %w{
  recipe[chef-solo-search]
  recipe[os-hardening]
  recipe[ssh-hardening]
  recipe[git]
  recipe[user::data_bag]
  recipe[user-unlock]
  recipe[sudo]
  recipe[service-foundation]
  }
