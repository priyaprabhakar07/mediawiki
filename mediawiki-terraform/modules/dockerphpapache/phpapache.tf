resource "docker_image" "phpapache" {
  name         = "php:8.1-apache"
  keep_locally = false
}

resource "docker_container" "phpapache" {
  image = docker_image.phpapache.image_id
  name  = "mediawiki"
  network_mode = "${docker_network.network.name}"
  ports {
    internal = 80
    external = 8080
  }
}
