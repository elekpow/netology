resource "yandex_mdb_postgresql_cluster" "elvm" {
  name                = "elvm"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.elvnet.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]
  deletion_protection = false

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "10"
    }
  }
  
   
  timeouts {
    create = "1h30m" # Полтора часа
    update = "2h"    # 2 часа
    delete = "30m"   # 30 минут
  }
  

  host {
    assign_public_ip = true 
    zone      = "ru-central1-a"
    #name      = "elvm-host-a"
    subnet_id = yandex_vpc_subnet.elvsubnet-a.id
  }
  
  
   host {
    assign_public_ip = true 
    zone      = "ru-central1-b"
    #name      = "elvm-host-b"
    subnet_id = yandex_vpc_subnet.elvsubnet-b.id
  }
  
  
  
}

resource "yandex_mdb_postgresql_database" "database" {
  cluster_id = yandex_mdb_postgresql_cluster.elvm.id
  name       = "database"
  owner      = "user1"
}

resource "yandex_mdb_postgresql_user" "user1" {
  cluster_id = yandex_mdb_postgresql_cluster.elvm.id
  name       = "user1"
  password   = "user1user1"
}

resource "yandex_vpc_network" "elvnet" {
  name = "elvnet"
}

resource "yandex_vpc_subnet" "elvsubnet-a" {
  name           = "elvsubnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.elvnet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}


resource "yandex_vpc_subnet" "elvsubnet-b" {
  name           = "elvsubnet-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.elvnet.id
  v4_cidr_blocks = ["10.15.0.0/24"]
}




resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = "pgsql-sg"
  network_id = yandex_vpc_network.elvnet.id

  ingress {
    description    = "PostgreSQL"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
}

