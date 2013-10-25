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

## Requirements

* `knife-solo` gem

Installation:

    gem install knife-solo

## Kickstart

For the impatient, install with default settings:

    ./setup.sh ubuntu@192.168.200.204

Or use the extended configuration:

    ./setup.sh ubuntu@192.168.200.204 ext

The Gist, if you prefer to do it yourself:

    host='192.168.200.204'
    sshkey=$(cat ~/.ssh/id_rsa.pub)

    cp nodes/example.json nodes/$host.json
    sed 's~.*ssh_keys.*~"ssh_keys":["'${sshkey}'"]~' -i data_bags/users/example.json
    knife solo bootstrap ubuntu@$host

    # and profit:
    ssh knife@$host


## Usage and Configuration

Convention: replace `mynode` with either your node's IP address or hostname.

1. **Configure your node**.
  You can use `nodes/example.json` as a starting point:

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

2. **Configure users** in `data_bags/users/`.
  You can use `example.json` to get started:

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

3. **Install**

        knife solo bootstrap ubuntu@mynode

  To update your server:

        knife solo cook ubuntu@mynode

  You may refer to the [knife-solo documentation](http://matschaffer.github.io/knife-solo/) for help.


If you want the optional components, please refer to `nodes/example_ext.json` and `data_bags/users/example_ext.json`.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Dominik Richter <dominik.richter@googlemail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
