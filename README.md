# mediawiki
Mediawiki

Following most of the steps given in https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Red_Hat_Linux and try below things
a. Try to dockerize PHP - Apache application and integrate mediawiki with this
b. Try to mysql in a docker
c. Created a userdefined bridge network for docker and
d. Tried to integrate the same interraform

   Pre-requisites at local
1. Docker desktop
2. Terragrunt and terraform installed

## a. Try to dockerize PHP - Apache application and integrate mediawiki with this
### First confirmed apache integration with PHP with necessary PHP extensions are setup
<img width="482" alt="Screenshot 2024-03-12 at 10 17 08 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/58d2c545-0aee-4d13-9b1e-0fe9ce7915f1">

### Second media wiki integrated
<img width="1403" alt="Screenshot 2024-03-12 at 10 16 09 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/54d56dec-448f-48a2-9574-6527c9963b51">

### ERROR
On checking, I could see some loop with $file requirement in PHP file in the media wiki index page

### Solution: 
May need to try with php image and try building apache and mediawiki on top of that image

### Commands used
```
docker build -t php-apache-mediawiki . --file ./Dockerfile
```
```
docker run \
  -it --rm \
  -p 8080:80 -p 443:443 \
  --name php-apache-mediawiki --network mediawiki-net \
  -v "$PWD":/var/www/html \
  -d php-apache-mediawiki

```
## b. Try to mysql in a docker

commands used

```
 docker run --name mediawikidb --network mediawiki-net -e \
MYSQL_ROOT_PASSWORD=$MYSQLPASS -e \
MYSQL_DATABASE=wikidatabase -e \
MYSQL_USER=wiki -e \
MYSQL_PASSWORD=$WIKIDBUSERPASS \
-d mysql:8
```

mysql Docker was up and able to connect and see the database and user

<img width="660" alt="Screenshot 2024-03-12 at 10 33 48 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/c887149a-30dc-4d78-9d1a-b29c50ee09c3">

## c. Created a userdefined bridge network for docker and
<img width="634" alt="Screenshot 2024-03-12 at 10 44 50 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/b76a957d-d4f4-4266-b91f-612fd4c23f06">

and both the Application and MySQL containers are in the same bridge to communicate

<img width="726" alt="Screenshot 2024-03-12 at 11 16 52 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/6e2cbf4c-1478-4784-9f69-4aa5154578b1">

## d. Intergration of docker with the TERRAGRUNT and TERRAFORM

<img width="565" alt="Screenshot 2024-03-12 at 11 20 07 PM" src="https://github.com/priyaprabhakar07/mediawiki/assets/103212725/1bea5096-939d-4d9b-ac28-8f686200b413">

<details> <Summary>TF plan fo PHP-Apache application CONTAINER </Summary>

```
priya ~/project/mediawiki-terraform/environment/dev/dockerphpapache  $ terragrunt plan
INFO[0000] Downloading Terraform configurations from file:///Users/priya/project/mediawiki-terraform/modules/dockerphpapache into /Users/priya/project/mediawiki-terraform/environment/dev/dockerphpapache/.terragrunt-cache/77Bzq2wN51x_G3in8sk2YcVS6e0/qMvELxu0UlEiM06ANV16MDK9dfY

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Installing kreuzwerker/docker v3.0.2...
- Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.phpapache will be created
  + resource "docker_container" "phpapache" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "mediawiki"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
terraform {
          + value = (known after apply)
        }

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }
resource "docker_image" "mysql" {

  # docker_image.phpapache will be created
  + resource "docker_image" "phpapache" {
      + id           = (known after apply)
      + image_id     = (known after apply)
resource "docker_image" "mysql" {
      + keep_locally = false
      + name         = "php:8.1-apache"
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
priya ~/project/mediawiki-terraform/environment/dev/dockerphpapache  $
```
</details>
<details> <Summary>TF plan for MySQL CONTAINER</Summary>

```
priya ~/project/mediawiki-terraform/environment/dev/dockermysql  $ terragrunt plan
INFO[0000] Downloading Terraform configurations from file:///Users/priya/project/mediawiki-terraform/modules/dockermysql into /Users/priya/project/mediawiki-terraform/environment/dev/dockermysql/.terragrunt-cache/Wl93EQiRJ8AKrxGBhYI8UA1lGIE/LsehqcW5b7jC5f89jNKt956qLNU

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Using previously-installed kreuzwerker/docker v3.0.2

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.mysql will be created
  + resource "docker_container" "mysql" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "mediawikidb"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + mounts {
          + source = "./"
          + target = "/var/lib/mysql/data"
          + type   = "bind"
        }

      + ports {
          + external = 3306
          + internal = 3306
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.mysql will be created
  + resource "docker_image" "mysql" {
resource "docker_network" "medianetwork" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = false
      + name         = "mysql:8"
resource "docker_image" "mysql" {
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```
</details>
<details> <Summary>TF plan for userdefined bridge NETWORK</Summary>

```
priya ~/project/mediawiki-terraform/environment/dev/dockernetwork  $ terragrunt plan
INFO[0000] Downloading Terraform configurations from file:///Users/priya/project/mediawiki-terraform/modules/dockernetwork into /Users/priya/project/mediawiki-terraform/environment/dev/dockernetwork/.terragrunt-cache/f-1h8H7LpqY7rrg30E0YY6Q2MqY/akpWomDAv9SFhzGErP0BpZzr2LE

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Installing kreuzwerker/docker v3.0.2...
- Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_network.medianetwork will be created
  + resource "docker_network" "medianetwork" {
      + driver      = "bridge"
      + id          = (known after apply)
      + internal    = (known after apply)
      + ipam_driver = "default"
      + name        = "medianetwork"
      + options     = (known after apply)
      + scope       = (known after apply)

      + ipam_config {
          + aux_address = (known after apply)
          + gateway     = (known after apply)
          + ip_range    = (known after apply)
          + subnet      = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
priya ~/project/mediawiki-terraform/environment/dev/dockernetwork  $
```
</details>

## IMPROVEMENTS
a. All confuration and naming can be added as variable

b. Tagging needs to be done

c. dependency can be created for network before crreating the docker container

## PENDING
a. Fix mediawiki code issue with application standalone docker setup

b. Integrating mediawiki with application container in terraform setup

c. Communication testing between the containers and others arre not carried out

d. All can be autmated with github actions so that for any change in code a full cycle of testing and notifications can be done
