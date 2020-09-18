Vagrant.configure("2") do |config|
config.vm.define :mvirtual1 do |mvirtual1|
mvirtual1.vm.box = "bento/ubuntu-18.04"
mvirtual1.vm.network :private_network, ip: "192.168.100.3"
mvirtual1.vm.hostname = "mvirtual1"
mvirtual1.vm.provision "shell", path: "haproxy.sh"
end
config.vm.define :mvirtual2 do |mvirtual2|
mvirtual2.vm.box = "bento/ubuntu-18.04"
mvirtual2.vm.network :private_network, ip: "192.168.100.4"
mvirtual2.vm.hostname = "mvirtual2"
mvirtual2.vm.provision "shell", path: "web.sh"
end
end