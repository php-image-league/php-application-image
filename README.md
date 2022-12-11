# Another dockerized symfony image!
This time an all-in-one container for developing, testing and deploying symfony projects.
This image contains all services that are needed for a deployed symfony application to run but no database and other
external services, **specifically designed for production use!**
  
**The Idea**  
Inspired by the way java frameworks like spring boot handle their build artifacts in a single executable that is runable
without any more configuration, I have implemented this image to provide a kind of equal solution for symfony(/php) projects.
The goal is simple: A ci build should end with a single binary to execute that just works when I spin it up.

## How to use
All source code has to be located inside `/var/www`. For local development you usually use the `latest-dev` tag and
mount a local project directory to this directory, when you build up a production image you usually copy the source code
of the current version into that directory and use the `latest` image tag.

## Quick start
As developers, we strive for performance and a steep learning curve, I got that. So how about a single-line example to
set up an example container for you so you can test it? I'm assuming you use `/Users/john_doe/Documents/my_symfony_project`
as a project root directory, but you can change that if it does not fit your needs (spoiler alert: you probably have to).
```shell script
docker run -it -p 8080:80 --volume=/Users/john_doe/Documents/my_symfony_project:/var/www phpimageleague/php-application-server:dev
```
After the container provisioned itself it should start nginx & php and you can access http://localhost:8080 to view your
application. If you're curious to view it in production environment, try removing `-dev` from the tag to use the
`latest` image tag.

## Container provisioning
Since we do not want any configuration after the container has been build and started, the image has to be configured to
provision itself as soon as a container will be created from it. We utilize the docker entrypoint for that, the image
has a custom entrypoint script that runs all files within `/usr/local/bin/provisioner/` everytime a container based on
our image is started up. Keep in mind: The entrypoint is called on **every** startup of the container, no matter if it is
a new container from that image or a existing container that has just been stopped. Make sure that the commands you fire
in your custom provisioner scripts are able to handle this (for example: don't drop the database and create a new one in a
provisioner script).
  
Currently, we provide basic provisioner scripts that run composer install and database migrations. Feel free to add
custom scripts or delete/update the ones that are provided in the image. After all provisioner scripts are ran, the
symfony cache will be warmed up and all other services (nginx, php) are started.

## Continuous Integration
Our custom docker image entrypoint is automatically called when the container starts... which is great, right?
Unfortunately, the downside of entrypoints is, that the container may look like it's running, but it actually still runs
the container provisioning from the entrypoint. To identify if a container is *really* ready, I've provided a small
script: `entrypoint_status` (`/usr/local/bin/entrypoint_status`). After creating a container from the image, you can
call entrypoint_status (e.g. `docker exec <container-name> entrypoint_status`), and the script will run until the container
is *truly* ready to exit with exit code 0 (success). If the container should not be able to start properly, it exits with
exit code 1 after 5 minutes to prevent your pipelines from getting stuck.

## Executing commands
Since your application is able to run in as many instances as you want now, why should we still execute our symfony commands
on the same container or (in case you orchestrate a fleet of containers) even the same physical machine? Huh, but starting
up a php-fpm as well as a nginx just for executing a single command is a very bad example, so let's use the cli image for
that. The CLI image does not start any services but provides us a single php executable, so it's up in no time:
```shell script
docker run -it --volume=/Users/john_doe/Documents/my_symfony_project:/var/www phpimageleague/php-aplication-server:cli php -v
```


## Available image tags

| PHP Version | 7.0 :name_badge: | 7.1  :name_badge: | 7.2 :name_badge: | 7.3 :name_badge: | 7.4 :name_badge:  | 8.0_ :x: | 8.1 :white_check_mark: | __8.2__ :white_check_mark:               |
|:------------|:-----------------|:------------------|:-----------------|:-----------------|:------------------|:---------|:-----------------------|:-----------------------------------------|
| __cli__     | cli-7.0          | cli-7.1           | cli-7.2          | cli-7.3          | cli-7.4<br/>cli-7 | cli-8.0  | cli-8.1                | __cli-8.2<br/>cli-8<br/>cli__            |
| __fpm__     | fpm-7.0          | fpm-7.1           | fpm-7.2          | fpm-7.3          | fpm-7.4<br/>fpm-7 | fpm-8.0  | fpm-8.1                | __fpm-8.2<br/>fpm-8<br/>fpm<br/>latest__ |
| __dev__     | dev-7.1          | dev-7.1           | dev-7.2          | dev-7.3          | dev-7.4<br/>dev-7 | dev-8.0  | dev-8.1                | __dev-8.2<br/>dev-8<br/>dev__            |

:name_badge:: DO NOT USE! This release is no longer maintained. These images are not part of our scheduled image update routine. Updates are executed irregularly using the "manual" action on Github. \
:x::	A release that is supported for critical security issues only. You can use it, but make sure to update your application to a version with full support soon. \
:white_check_mark:: Version is in full support, all fine!

__Attention:__ Since this is updated by people, make sure to double-check your version support on [the official PHP roadmap](https://www.php.net/supported-versions.php) in case we forgot to update this!


