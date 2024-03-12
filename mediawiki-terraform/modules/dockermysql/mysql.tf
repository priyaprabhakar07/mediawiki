resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = false
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name = "mediawikidb"
  mounts {
    source = "./"
    target = "/var/lib/mysql/data"
    type = "bind"
  }
  network_mode = "${docker_network.network.name}"
  ports {
    internal = 3306
    external = 3306
  }
}
