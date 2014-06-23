name "base"
description "Basic work server configuration"
run_list %w{
  recipe[chef-solo-search]
  recipe[git]
  recipe[user::data_bag]
  recipe[user-unlock]
  recipe[sudo]
  recipe[service-foundation]
  }
