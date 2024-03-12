resource "docker_network" "medianetwork" {
  name = "medianetwork"
  driver = "bridge"
}
