resource "yandex_compute_instance" "vm-ter" {
  count = "${length(var.hostnames)}"
  name = "vm-ter-${count.index}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  hostname = "${var.hostnames[count.index]}"
  
  resources {
    core_fraction = 20 
    cores  = 2
    memory = 2
  }
## debian 10
  boot_disk {
    initialize_params {
      image_id = "fd8u2e47jlq81vqvg87t"
      type = "network-ssd"
      size = "5"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_ter.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./metadata.yml")}"
  }
  
## install-docker
 provisioner "remote-exec" {
   inline = [
	 "curl -fsSL https://get.docker.com -o install-docker.sh",
	 "sh install-docker.sh --dry-run",
	 "sudo sh install-docker.sh",
     "sudo apt-get install python-minimal -y",	
    ]
    connection {
     type = "ssh"
     user = "${var.ssh_user}" 
     host = self.network_interface.0.nat_ip_address
     agent = true # eval "$(ssh-agent -s)" # ssh-add ~/.ssh/id_rsa
   }
}


## ANSIBLE first install
 provisioner "local-exec" {
   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.network_interface.0.nat_ip_address},' ./ansible/install.yml"
 }
}
## network
resource "yandex_vpc_network" "network_ter" {
  name = "net_ter[count.index]"
}
## network _ subnet
resource "yandex_vpc_subnet" "subnet_ter" {
  name           = "subnet_ter[count.index]"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_ter.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


