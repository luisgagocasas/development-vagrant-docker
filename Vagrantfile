VM_IP = "192.168.1.200"

unless Vagrant.has_plugin?("vagrant-docker-compose")
  system("vagrant plugin install vagrant-docker-compose")
  puts "Dependencies installed, please try the command again."
  exit
end

Vagrant.configure("2") do |config|
  config.vm.define "server1" do |server1|
    server1.vm.hostname = "server1"
    server1.vm.box = "ubuntu/focal64"
    server1.vm.box_version = "20211026.0.0"
    server1.ssh.insert_key = true
    server1.vm.box_check_update = false
    server1.vm.synced_folder "project/", "/home/vagrant/project"
    server1.vm.provision:shell, inline: <<-SHELL
    echo "root:rootroot" | sudo chpasswd
    sudo timedatectl set-timezone America/Lima
    SHELL
    server1.vm.network :public_network, ip: VM_IP
    server1.vm.provision :shell, inline: "apt-get update"
    server1.vm.provision :shell, path: "init.sh"
    # server1.vm.provision "shell", path: "init.sh", args: "lb"
    server1.vm.provision :docker
    server1.vm.provision :docker_compose, yml: "/home/vagrant/project/docker-compose.yml", run: "always"
  end
end