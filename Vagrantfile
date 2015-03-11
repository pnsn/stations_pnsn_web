# # -*- mode: ruby -*-
# # vi: set ft=ruby :
# 
# Vagrant.configure("2") do |config|
#   box = "centos6.4_base.box"
#   config.vm.box = box
#   config.vm.provider :virtualbox do |vb|
#     vb.customize [ "modifyvm", :id, "--memory", 1024]  
#     vb.customize [ "modifyvm", :id, "--ioapic", "on"]
#   end
#   config.vm.synced_folder "./", "/vagrant/"
#   # unless ENV['OS'] =~ /NT/ then #Checks for 'Windows_NT' or 'CYGWIN_NT'
#   config.vm.network :private_network, ip: "10.10.10.11"
# 
#     # do NOT download the iso file from a webserver
#     # config.vbguest.no_remote = true
#     # config.vbguest.auto_update = true
#   # end
#   
#   
#   #port forwarding
#   config.vm.network :forwarded_port, guest: 4567, host: 4567
# end



# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  box = "centos6.4_base.box"
  config.vm.box = box
  config.vm.provider :virtualbox do |vb|
    #comment this out if you want to use centos5 which defaults to name "default"
    vb.customize [ "modifyvm", :id, "--memory", 2048]  
    vb.customize [ "modifyvm", :id, "--ioapic", "on"]
  end
  
  config.vm.synced_folder "./", "/vagrant/"
  # config.vm.network :private_network, ip: "10.10.10.12"  
  
  #port forwarding
  config.vm.network :forwarded_port, guest: 3000, host: 3000


end
