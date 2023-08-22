terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "${var.zone_a}"
  token                    = ""
  cloud_id                 = ""
  folder_id                = ""
}
