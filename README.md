# README

This README is meant to document to users how to get our app up and running.

Currently, our app is up an running on a Ubuntu server using NGINX. 

This was built by: Leo Carten, Charles Cross, Samuel Faucher, and Christopher Costigan

**Ruby version**

* Requires ruby version 3.2.2

**Rails version**

* Requires rails >= 7.0.8

**Instructions to test locally**

1. Clone repository.

2. Run `bin/dev` in the directory of the project. The reason for this command instead of `rails server` is because we are using Tailwind CSS.

3. View on `localhost:3000`.

**Database creation**

* Sqlite3

**CSS Framework**

* A great video to integrate Tailwind CSS with Rails is here: https://www.youtube.com/watch?v=GGpt2TEkDqo


**Instructions to host our application**

A guide created by Leo Carten to deploy a rails app on a Digial Ocean Droplet.

Pleaes also use this as a reference: https://gorails.com/deploy/ubuntu/22.04#vps

Please follow these instructions step-by-step. 

1. Create an account with Digial Ocean.
2. Create a Droplet.
    - OS: Ubuntu.
    - Version: 22.04 [LTS]
    - Droplet Type: Basic
    - CPU Options: Regular
    - Choose cheapest plan [$4 / month]
    - You want to use an SSH key for authentication. Please refer to instructions #3 below.
3. SSH key
    - Open Terminal
    - Run: ssh-keygen
    - It's going to ask you for a name, please call it: dummy_ssh
    - Do not enter a passphrase [just press Enter]
    - Run: cat dummy_ssh.pub [This should display your public key]
    - Copy this key
    - Go back to digital Ocean.
    - Select New SSH Key.
    - Paste your public key into SSH key content
    - Name this key "dummy_ssh"
    - Click Add SSH Key
    - Click Create Droplet at the bottom [This will take ~60 seconds to spin up].
4. SSH into your server from Terminal.
    - Copy your servers IP address
    - Open Terminal and run: ssh root@IP_Address [i.e. for me, I run: ssh root@64.23.140.153 because that is my IP Address]
    - If this does not work:
        - That's fine. Your computer most likely has a default SSH key to use already set up. Instead, run:
            ssh -i dummy_ssh root@64.23.140.153
        - The i flag explicitely tells your computer to use the SSH key we created in step #3.
    - You have successfully SSH'ed into your server!
5. Create a new user on your server.
    - It's not good practice to deploy apps onto the root user of a server. Please follow the commands below:
        adduser deploy
        Feel free to just leave the following blank, i.e.:
            Enter the new value, or press ENTER for the default
            Full Name []: 
            Room Number []: 
            Work Phone []: 
            Home Phone []: 
            Other []: 
            Is the information correct? [Y/n] y
        adduser deploy sudo
6. Now that we have added a new user, we also need to add the SSH key to this. Please follow instructions below:
    - Navigate to your deploy user: 
        cd ..
        ls 
    - You should see the following directories:
        bin   dev  home  lib32  libx32      media  opt   root  sbin  srv  tmp  var
        boot  etc  lib   lib64  lost+found  mnt    proc  run   snap  sys  usr
    - cd home
    - cd deploy
    - mkdir .ssh
    - cd .ssh
    - nano authorized_keys
    - Paste the public key from step #3 into this file.
7. SSH'ing to your new deploy user.
    - Try to SSH into your new user by running a command like this: ssh -i dummy_ssh deploy@IP_Address [i.e. I run: ssh -i dummy_ssh deploy@64.23.140.153]
    - You should have gotten in!!

*For all instruction below, please make sure you are accessing the server via the deploy user*

8. Installing Softwares onto the server.
    - Please run these commands in seqeuntial order:
        curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            - The above may give an odd message. Unfortanetly, you need to wait the full 60 seconds for it to go away so you can install the software.
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo add-apt-repository ppa:chris-lea/redis-server
        sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn
9. Install Ruby onto our server.
    - Please run in seqeuntial order:
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(rbenv init -)"' >> ~/.bashrc
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
        git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
        exec $SHELL
        rbenv install 3.2.2
             - The above command takes awhile. Please except a ~15 minutes wait.
        rbenv global 3.2.2
        ruby -v 
            - Your output should be something like: ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]
        gem install bundler
10. We need to install a Web Server. We will be installing NGINX and Passenger.
    - Please execute in seqeuntial order:
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
        sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger $(lsb_release -cs) main > /etc/apt/sources.list.d/passenger.list'
        sudo apt-get update
        sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
        if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
        sudo ls /etc/nginx/conf.d/mod-http-passenger.conf
        sudo nano /etc/nginx/conf.d/mod-http-passenger.conf
            - Delete the line that reads: passenger_ruby /usr/bin/passenger_free_ruby;
            - Add this line instead: passenger_ruby /home/deploy/.rbenv/shims/ruby;
        sudo service nginx start
11. Web Server Check
    - You can check and make sure NGINX is running by visiting your server's public IP address in your browser and you should be greeted with the "Welcome to NGINX" message.
12. Add a specific version of NGINX.
    - mkdir production_demo
    - sudo rm /etc/nginx/sites-enabled/default
    - sudo nano /etc/nginx/sites-enabled/production_demo
        - Inside of this file, paste the following:
            server {
            listen 80;
            listen [::]:80;

            server_name _;
            root /home/deploy/production_demo/current/public;

            passenger_enabled on;
            passenger_app_env production;
            passenger_preload_bundler on;

            location /cable {
                passenger_app_group_name production_demo_websocket;
                passenger_force_max_concurrent_requests_per_process 0;
            }

            # Allow uploads up to 100MB in size
            client_max_body_size 100m;

            location ~ ^/(assets|packs) {
                expires max;
                gzip_static on;
            }
            }
    - sudo service nginx reload

13. Local Machine: create a new 
    - On your local machine, create a new rails project:
        rails new production_demo
    - Navigate to the Gemfile of the repository: 
        gem 'capistrano', '~> 3.11'
        gem 'capistrano-rails', '~> 1.4'
        gem 'capistrano-passenger', '~> 0.2.0'
        gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
    - Run these commands:
        bundle
        cap install STAGES=production
    - Make sure your Capfile includes these lines:
        require 'capistrano/rails'
        require 'capistrano/passenger'
        require 'capistrano/rbenv'

        set :rbenv_type, :user
        set :rbenv_ruby, '3.2.2'
    - Delete everything in the file: config/deploy.rb 
    - Add this:
        set :application, "production_demo"
        set :repo_url, "git@github.com:leocarten/dummyproduction.git"

        # Deploy to the user's home directory
        set :deploy_to, "/home/deploy/#{fetch :application}"

        append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

        # Only keep the last 5 releases to save disk space
        set :keep_releases, 5
    - PLEASE MADE SURE YOU EDIT THE REPO_URL TO YOUR USERNAME AND REPOSITORY NAME!
    - Navigate to config/deploy/production.rb to point to our server's IP address for production deployments. Make sure to replace 1.2.3.4 with your server's public IP.
        server '1.2.3.4', user: 'deploy', roles: %w{app db web}
14. Get our passkeys
    - For step #15, you are going to need some keys. 
    - Your mastey key is located in: /config/master.key
    - Your secret key is found by running the following command:
        EDITOR="mate --wait" bin/rails credentials:edit
        EDITOR=nano rails credentials:edit

15. SSH into the deploy user to add a few last things.
    - SSH into your deploy user [i.e. I run: ssh -i dummy_ssh deploy@64.23.140.153]
    - Run these commands:
        mkdir /home/deploy/production_demo
        nano /home/deploy/production_demo/.rbenv-vars
            - Using the keys we established in step #14, please edit the file accordingly:
                RAILS_MASTER_KEY=
                SECRET_KEY_BASE=
16. Please push the local rails app to a Github repository. The link to this repository should be the same as the repo you set in step #13.
    - For example, this is the github repo i created for this dummy tutorial: https://github.com/leocarten/dummy_production
    - There are a few more steps, but this YT tutorial does a good job. Please start watching at 21 minutes: https://www.youtube.com/watch?v=xpYpaRUFzTI&t=1272s