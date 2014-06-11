# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.network :forwarded_port, host: 8088, guest: 80
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=775,fmode=664"]
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end
end
