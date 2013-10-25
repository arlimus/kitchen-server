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
          "users": [
            "ubuntu"
          ],
          "run_list": [
            "role[vagrant]"
          ]
        }


2. Configure your users in `data_bags/users/`. You can use `example.json` to get started:

        cp data_bags/users/example.json data_bags/users/ubuntu.json

  Now edit `data_bags/users/ubuntu.json`. Don't forget to add your ssh public key so you can log in with the user:

        {
          "id"            : "ubuntu",
          "comment"       : "Mr. Ubuntu",
          "home"          : "/home/ubuntu",
          "groups"        : ["admin"],

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