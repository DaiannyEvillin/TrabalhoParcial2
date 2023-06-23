Vagrant.configure("2") do |config|
  # Configura a box
  config.vm.box = "ubuntu/focal64"

  # Configura a quantidade de vCPUs e a memória RAM
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "1024"
  end

  # Mapeia um volume com o nome do aluno
  config.vm.synced_folder ".", "/aluno"

  # Cria uma interface de rede privada com o IP 192.168.1.254/24
  config.vm.network :private_network, ip: "192.168.1.254"

  # Redirecionamento de porta do host para a VM
  config.vm.network :forwarded_port, guest: 80, host: 80, host_ip: "127.0.0.1", auto_correct: true

  # Executa o script de provisionamento durante a criação da VM
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant
    bash provision.sh
  SHELL
end




