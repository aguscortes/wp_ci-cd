# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "prod" do |prod|
    prod.vm.box = "centos/7"
    prod.vm.hostname = 'prod'
    prod.vm.box_url = "centos/7"

    prod.vm.network :public_network, ip: "192.168.1.100"
    prod.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "prod"]
    end
    config.vm.provision "shell", path: 'docker.sh'   
  end

  config.vm.define "dev" do |dev|
    dev.vm.box = "centos/7"
    dev.vm.hostname = 'dev'
    dev.vm.box_url = "centos/7"

    dev.vm.network :public_network, ip: "192.168.1.101"
    dev.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "dev"]
    end
    config.vm.provision "shell", path: 'docker.sh'   
  end

  config.vm.define "test" do |test|
    test.vm.box = "centos/7"
    test.vm.hostname = 'test'
    test.vm.box_url = "centos/7"

    test.vm.network :public_network, ip: "192.168.1.102"
    test.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "test"]
    end
    config.vm.provision "shell", path: 'docker.sh'
  end
end