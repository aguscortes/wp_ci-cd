# -*- mode: ruby -*-
# vi: set ft=ruby :

hosts = {"prod" => "192.168.1.100", "dev" => "192.168.1.101", "test" => "192.168.1.102"}
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  hosts.each do |name, ip|
    config.vm.define name do |machine|      
      machine.vm.hostname = name
      machine.vm.box_url = "centos/7"
      machine.vm.synced_folder name + "/wordpress", "/home/vagrant/docker/wordpress", type: "virtualbox", owner: "vagrant", group: "vagrant"
      machine.vm.synced_folder name + "/mysql", "/home/vagrant/docker/mysql", type: "virtualbox", owner: "vagrant", group: "vagrant"
      machine.vm.synced_folder name + "/nginx", "/home/vagrant/docker/nginx", type: "virtualbox", owner: "vagrant", group: "vagrant"
      machine.vm.network :public_network, ip: "192.168.1.100"
      machine.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 512]
        v.customize ["modifyvm", :id, "--name", "prod"]
      end
      config.vm.provision "shell", path: 'docker.sh'  
      config.ssh.keys_only = false
      config.ssh.keep_alive = true  
    end
  end  
end
