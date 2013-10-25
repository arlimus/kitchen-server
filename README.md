# kitchen server

... a server's kitchen. It configures a vanilla Ubuntu server to have:

* virtualbox
* vagrant
* berkshelf
* librarian-puppet
* puppet
* chef

Optional components:

* zsh
* gitconfig
* extra packages

## Usage and Configuration

Convention: replace `mynode` with either your node's IP address or hostname.

1. Configure your kitchen. You can use `nodes/example.json` as a starting point:

        cp nodes/example.json nodes/mynode.json

  Now edit `nodes/mynode.json`:

        {
          "vagrant": {
            "url": "http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb",
            "checksum": "db7d06f46e801523d97b6e344ea0e4fe942f630cc20ab1706e4c996872f8cd71",
            "plugins": ["vagrant-berkshelf"]
          },

          "users": [
            "ubuntu"
          ],

          "run_list": [
             "recipe[chef-solo-search]"
            ,"recipe[git]"
            ,"recipe[user::data_bag]"
            ,"recipe[virtualbox]"
            ,"recipe[vagrant]"
            ,"recipe[service-foundation]"
          ]
        }

2. Configure your users in `data_bags/users/`. You can use `example.json` to get started. Don't forget to add your ssh key:

        cp data_bags/users/example.json data_bags/users/ubuntu.json

  Now edit `data_bags/users/ubuntu.json`:

        {
          // basic user config
          "id"            : "ubuntu",
          "comment"       : "Mr. Ubuntu",
          "home"          : "/home/ubuntu",
          "groups"        : ["admin"],

          // ssh keys
          "ssh_keys"      : [
            "ssh-rsa AAAAB3..."
            ]
        }

3. Get the kitchen online:

        knife solo bootstrap ubuntu@mynode

  To update your server later on:

        knife solo cook ubuntu@mynode

  You may refer to the [knife-solo documentation](http://matschaffer.github.io/knife-solo/) for help.


If you want the optional components, please refer to `nodes/example_ext.json` and `data_bags/users/example_ext.json`.