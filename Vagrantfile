Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # VM 1: Jenkins
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network "private_network", ip: "192.168.56.10"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8081

    jenkins.vm.provider "virtualbox" do |vb|
      vb.name = "vm-jenkins"
      vb.memory = "1024"
      vb.cpus = 2
    end

    jenkins.vm.provision "shell", path: "vagrant/scripts/setup-jenkins.sh"
  end

  # VM 2: Produção (Prod)
  config.vm.define "prod" do |prod|
    prod.vm.hostname = "prod"
    prod.vm.network "private_network", ip: "192.168.56.20"
    prod.vm.synced_folder "./app", "/var/www/app", create: true

    prod.vm.provider "virtualbox" do |vb|
      vb.name = "vm-prod"
      vb.memory = "1024"
      vb.cpus = 1
    end

    prod.vm.provision "shell", path: "vagrant/scripts/setup-node.sh"
  end
end