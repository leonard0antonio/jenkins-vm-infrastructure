Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # VM 1: Jenkins
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network "private_network", ip: "192.168.56.10"

    jenkins.vm.provider "virtualbox" do |vb|
      vb.name = "vm-jenkins"
      vb.memory = "1024"
      vb.cpus = 1
    end

    jenkins.vm.provision "shell", path: "vagrant/scripts/setup-jenkins.sh"
  end

  # VM 2: Produção (Prod)
  config.vm.define "prod" do |prod|
    prod.vm.hostname = "prod"
    prod.vm.network "private_network", ip: "192.168.56.20"

    prod.vm.provider "virtualbox" do |vb|
      vb.name = "vm-prod"
      vb.memory = "1024"
      vb.cpus = 1
    end

    prod.vm.provision "shell", path: "vagrant/scripts/setup-node.sh"
  end

  # VM 3: Nexus
  config.vm.define "nexus" do |nexus|
    nexus.vm.hostname = "nexus-server"
    nexus.vm.network "private_network", ip: "192.168.56.30"

    nexus.vm.provider "virtualbox" do |v|
      v.name = "vm-nexus"
      v.memory = 2048
      v.cpus = 2
    end
  end
end