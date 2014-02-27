# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "raring"
BOX_URI = ENV['BOX_URI'] || "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"
IP_ADDRESS = ENV['IP_ADDRESS'] || "10.0.0.100"
VB_NAME = ENV['VB_NAME'] || "Drampal"

Vagrant.configure("2") do |config|
  # Get the Box
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI
  # Setup the Box
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.name = VB_NAME
  end
  # Network Configuration
  config.vm.network :private_network, ip: IP_ADDRESS
  # Provision the Box
  config.vm.provision :shell, :path => "vagrant.sh"
end

