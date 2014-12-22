# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
 config.vm.define "moodle" do |moodle|
    moodle.vm.box = "mtravis/moodle"
    moodle.vm.hostname = "moodle.local.lan"
    moodle.vm.network :private_network, ip: "172.16.46.5"
    moodle.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end
	
end
