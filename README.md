docker-nginx
============

An nginx container to be linked with php-fpm

I have created this nginx image for easy deploy of simple php websites. 

It is meant to be used together with my php-fpm container.

Use Fig. A fig.yml script is available with the project, reading it revealso some aditional customizatio options, such as addidng custom nginx configs.

The basis container structure of this deploy is as follows,

- A data container, which is either filled with project files by building a special image(preferable for deploys), or is using volumes to bind the project directory. This container must have the project files available as volumes on /opt/web.

- A php-fpm container. This container has the port 9000 exposed and is listening for incomming connections with the directive ```listen = 0.0.0.0:9000``` wihch is already done in it's dockerfile - available in my docker-php-fpm project. This container must be using  ```--volumes-from  prjData``` to have project files available.

- The nginx container - this container is mounted locally on port 80 (and port 443). It should be linked to the php container and must use ```--volumes-from prjData```.

For simple use:
-----------------------
- Install docker and fig - (docker should be available in your linux repo and fig can be instqalled via pip(which is available in your linux repo)). 

- Copy the fix.yml file to your project.

- If you have a web server running on port 80, turn it off or change the port to which fig binds the nginx container in the fig.yml file to an alternative port.

- cd to your project and run ```fig up``` - this should start everything as it should be.

Note:
====
 - If you plan to use multiple websites, you have several options. My favorite is to run a central nginx whic is linked to all other nginx containers and then acts as a reverse proxy for other nginx containers.

 - If you're using a php framework or a cms, etc. make shure to write a proper nginx config and use it on the nginx container, or it won't work.


Acessing containers:
===============
- So you want to enter your containers for reason X?
 - In older versions of docker, the viable option was to create a second container like this : ```docker run -ti --rm --volumes-from <target-container> bash```
 - with new docer versions you can simply run a new process inside your existing container: ```docker exec  -ti <target container> <command>```, where the comand will probably be ```bash```
