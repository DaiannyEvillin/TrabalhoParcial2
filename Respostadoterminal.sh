root@daianny-Lenovo-ideapad-320-15IKB:/home/daianny# vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ubuntu/bionic64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/bionic64' version '20210916.0.0' is up to date...
==> default: Setting the name of the VM: project_default_1621014603285_66098
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 80 (guest) => 8080 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /home/daianny/project
==> default: Running provisioner: shell...
    default: Running: /tmp/vagrant-shell202305-3197-1fhjg7w.sh
    default: Configuring firewall rules...
    default: Firewall rules configured successfully.
==> default: Running provisioner: shell...
    default: Running: /tmp/vagrant-shell202305-3197-1rdo8h4.sh
    default: Executing script...
    default: Script executed successfully.

