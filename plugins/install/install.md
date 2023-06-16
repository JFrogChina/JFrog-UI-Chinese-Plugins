# install

- guide

        - system architecture
        https://www.jfrog.com/confluence/display/JFROG/System+Architecture

        - install
        https://www.jfrog.com/confluence/display/JFROG/Install

        - download
        https://jfrog.com/download-legacy/?product=artifactory&installer=rpm

        - system requirements
        https://www.jfrog.com/confluence/display/JFROG/System+Requirements

        - system.yaml of art
        https://www.jfrog.com/confluence/display/JFROG/Artifactory+System+YAML

        - storage configuration
        https://www.jfrog.com/confluence/display/JFROG/Configuring+the+Filestore

- common install requirement

        - system check
        nproc
        free -m
        df -h
        ulimit -a 
        date
        hostname
        hostname -i
        // make sure  art/xray's hostname different
        
        - firewall
        systemctl stop firewalld
        systemctl disable firewalld
        service docker restart (fix ERROR: Failed to Setup IP tables)
        
        - linux
        setenforce 0
        yum update -y

        - sync time
        yum install -y ntpdate
        ntpdate ntp1.aliyun.com

        - disable ipv6
        vi /etc/sysctl.conf
        net.ipv6.conf.all.disable_ipv6=1

        vi /etc/sysconfig/network
        NETWORKING_IPV6=no

        sysctl -p
        chkconfig ip6tables off

- E+ install

        - E
        
                3 artifactory + xray + (optional mission)
        
        - E+
        
                6 artifactory + xray + mission + distribution + 5 edge
                2 trial license to access art and edge + 1 xray trial license
                E+ license to activate all nodes(5 arts + 6 edges)

        - architecture & docker images

                1. art
                docker.bintray.io/jfrog/artifactory-pro   7.15.3             1b83887a89be   6 weeks ago    916MB
                docker.bintray.io/postgres                12.5-alpine        b5a8143fc58d   4 months ago   158MB
                nginx

                        - mission
                        docker.bintray.io/jfrog/router:7.16.1
                        docker.bintray.io/jfrog/mission-control:4.7.2
                        docker.bintray.io/jfrog/insight-scheduler:4.7.2
                        docker.bintray.io/jfrog/insight-server:4.7.2
                        docker.bintray.io/jfrog/elasticsearch-oss-sg:7.10.2

                2. xray
                docker.bintray.io/jfrog/xray-analysis     3.15.3             68a4f9fad679   2 months ago   427MB
                docker.bintray.io/jfrog/xray-persist      3.15.3             043ac652798b   2 months ago   427MB
                docker.bintray.io/jfrog/xray-indexer      3.15.3             48ae82bee2cc   2 months ago   427MB
                docker.bintray.io/jfrog/xray-server       3.15.3             0ffce7d6eb77   2 months ago   712MB
                docker.bintray.io/jfrog/router            7.12.4             811a69b4d581   3 months ago   212MB
                docker.bintray.io/postgres                12.5-alpine        b5a8143fc58d   4 months ago   158MB
                observability:1.6.1
                docker.bintray.io/jfrog/xray-rabbitmq     3.8.9-management   2a2cf2d84722   3 months ago   186MB
                
                3. distribution
                distribution-distribution:2.13.4
                router:7.38.0
                observability:1.6.1
                redis:6.2.6-debian-10-r43

                4. edge
                artifactory
                nginx

                5. pipelines
                pipelines
                postgres
                rabbitmq
                reids
                vault

                6. pdn
                server:1.0.3
                router:7.36.1
                observability:1.5.1

- HA install

        - guide

                1 cluster = 2 art nodes
                docker compose

        - node1 (by docker compose)
       
                119.23.40.143
                root/Welcome1

                ./config.sh

                artifactory/postgre

                vi .jfrog/artifactory/var/etc/system.yaml
                check node1_system.yaml

                docker-compose -p rt-postgres -f docker-compose-postgres.yaml up -d
                docker-compose -p rt up -d

                http://119.23.40.143:8082/ui/admin/license_management/licenses
                admin/Welcome1

                add license

                cat .jfrog/artifactory/var/etc/security/master.key
                master key=83370fd54ad18e72cb52e5cbd61431e9302a23d3d6527ff762fa435074337be5

        - node2 (by docker compose)
        
                119.23.48.54
                Welcome1

                ./config.sh

                choose to add existing cluser
                provide master key
                choose postgresql as external database (from node1 system.yaml)

                docker-compose -p rt up -d

                add license from node1 -> license
                then node2 will be healthy status

                http://119.23.48.54:8082
                base url automatically will be node's base url
                
        - xray / mission

                tested, can stop art on node2, and install xray or mission

        - load balance

                - change storage type
                        
                        vi .jfrog/artifactory/var/etc/artifactory/binarystore.xml
                        <config version="2">
                                <chain template="cluster-file-system"/>
                        </config>

                - config nginx

                        art -> http settings -> use nginx 80 -> save
                        it will generate HA proxy to 2 nodes

                        http://119.23.40.143/ui/packages

- artifactory

        - rpm (centos, tested for E+. qilin x86 works)

                - install by rpm package (.rpm file, find this small link in the pop up window)
                
                        wget https://releases.jfrog.io/artifactory/artifactory-pro-rpms/jfrog-artifactory-pro/jfrog-artifactory-pro-7.21.3.rpm

                        yum install -y jfrog-artifactory-pro-7.21.3.rpm

                - or install by rpm repo
                
                        wget https://releases.jfrog.io/artifactory/artifactory-pro-rpms/artifactory-pro-rpms.repo -O jfrog-artifactory-pro-rpms.repo;
                        mv jfrog-artifactory-pro-rpms.repo /etc/yum.repos.d/;
                        yum update
                        yum install jfrog-artifactory-pro-7.21.3

                - start
                
                        systemctl start artifactory

                - check log
                
                        tail -f /var/opt/jfrog/artifactory/log/console.log
                        all services started (no this message in new versions, check page) 

                - visit
                
                        http://localhost:8082/ui/
                        admin/password

                - add trial licence
                
                        base url=http://public_ip:8082/

                - change config
                
                        vi /opt/jfrog/artifactory/var/etc/system.yaml
                                -> node (refer to system.full-template.yaml)
                                -> db

                                artifactory:
                                  port: 9081

                                router:
                                  entrypoints:
                                    externalPort: 9082

                        vi /opt/jfrog/artifactory/var/etc/artifactory/binarystore.yaml

                - restart

                        systemctl restart artifactory
                        
        - docker (only art has non docker-compose install)

                - install
                
                        vi /etc/profile
                        export JFROG_HOME=/opt/jfrog
                        source /etc/profile

                        mkdir -p $JFROG_HOME/artifactory/var/etc/
                        cd $JFROG_HOME/artifactory/var/etc/
                        touch ./system.yaml
                        chown -R 1030:1030 $JFROG_HOME/artifactory/var

                        (if mac)
                        chmod -R 777 $JFROG_HOME/artifactory/var

                - configure system.yaml
              
                        For Docker installations, verify that the host's ID shared.node.id and IP shared.node.ip are added to the system.yaml. 
                        If these are not manually added, they are automatically resolved as the the container's IP, meaning other nodes and services will not be able to reach this instance

                        vi $JFROG_HOME/artifactory/var/etc/system.yaml
                        check art_docker_system.yaml

                - start (latest version usually has bugs)
                        
                        docker run --name artifactory -v $JFROG_HOME/artifactory/var/:/var/opt/jfrog/artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-pro:7.21.3

                - check log

                        docker ps
                        docker logs -f artifactory

                - stop

                        docker stop artifactory

        - docker compose (tested for HA install, failed to install on the same art server)

                - install
                        
                        wget https://releases.jfrog.io/artifactory/artifactory-pro/org/artifactory/pro/docker/jfrog-artifactory-pro/7.16.3/jfrog-artifactory-pro-7.16.3-compose.tar.gz
               
                        tar -xvf jfrog-artifactory-<pro|oss|jcr|cpp-ce>-<version>-compose.tar.gz
                        cd artifactory-pro-7.16.3
                        
                        ./config.sh (generate docker compose yaml file & create postgre container)
                        Installation directory: [/root/.jfrog/artifactory] contains data and configurations.

                - option to change port
                
                        vi docker-compose.yaml
                        8081:8081 -> 9081:8081
                        $JF_ROUTER_ENTRYPOINTS_EXTERNALPORT:$JF_ROUTER_ENTRYPOINTS_EXTERNALPORT -> $env_router_port:9082

                        vi .env
                        8082 -> 9082

                - start
                
                        docker-compose -p rt-postgres -f docker-compose-postgres.yaml up -d
                        docker-compose -p rt up -d
                        docker-compose -p rt ps
                        docker-compose -p rt down

                - visit
                
                        http://SERVER_HOSTNAME:8082/ui/
                        base url=http://SERVER_HOSTNAME:8082

                - check log
                
                        docker-compose -p rt logs -f

                - add edge into art
                
                        art -> admin -> platform deployment -> http://ip_of_edge:9082 (edge port)

        - docker, arm

                - install docker

                        wget https://download.docker.com/linux/static/stable/aarch64/docker-20.10.9.tgz
                        tar -zxvf docker-20.10.9.tgz
                        cp docker/* /usr/bin/          (/user/bin is in PATH, so dockerd can be found) 
                        dockerd &
                        docker run hello-world

                - install postgre on arm

                        - install docker-20.10.9
                        if not, error = ls: cannot access '/docker-entrypoint-initdb.d/': Operation not permitted

                        - dns
                        if not, error = Get https://registry-1.docker.io/v2/: dial tcp ...

                        vi /etc/resolv.conf
                        nameserver 114.114.114.114
                        search localdomain

                        - start
                        docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 --net host -d postgres

                        if only access to private ip of vm of PG
                        use --net host

                        default db = postgres
                        default user/pass = postgres/mysecretpassword

                - install
                
                        vi /etc/profile
                        export JFROG_HOME=/opt/jfrog
                        source /etc/profile

                        mkdir -p $JFROG_HOME/artifactory/var/etc/
                        cd $JFROG_HOME/artifactory/var/etc/
                        touch ./system.yaml
                        chown -R 1030:1030 $JFROG_HOME/artifactory/var

                        (if mac)
                        chmod -R 777 $JFROG_HOME/artifactory/var

                - configure system.yaml
              
                        For Docker installations, verify that the host's ID shared.node.id and IP shared.node.ip are added to the system.yaml. 
                        If these are not manually added, they are automatically resolved as the the container's IP, meaning other nodes and services will not be able to reach this instance

                        vi $JFROG_HOME/artifactory/var/etc/system.yaml
                        check art_docker_arm_system.yaml

                - start
                        
                        docker run --name artifactory -v $JFROG_HOME/artifactory/var/:/var/opt/jfrog/artifactory -d -p 8081:8081 -p 8082:8082 --net host releases-docker.jfrog.io/jfrog/artifactory-pro:7.41.4

                        if only access to private ip of vm of PG
                        use --net host to have route to the host of the installed postgre

                - check log

                        docker ps
                        docker logs -f artifactory

                - stop

                        docker stop artifactory
        
        - linux binary (M1 ubuntu UTM failed)

                - install
                
                        wget https://releases.jfrog.io/artifactory/artifactory-pro/org/artifactory/pro/jfrog-artifactory-pro/7.16.3/jfrog-artifactory-pro-7.16.3-linux.tar.gz

                        mkdir -p /opt/jfrog
                        mv jfrog-artifactory-pro-7.16.3-linux.tar.gz /opt/jfrog
                        cd /opt/jfrog

                        tar -xvf jfrog-artifactory-pro-7.16.3-linux.tar.gz
                        mv artifactory-pro-7.16.3/ artifactory

                        vi /etc/profile
                        export JFROG_HOME=/opt/jfrog
                        export PATH=$PATH:$JFROG_HOME/artifactory/app/bin
                        source /etc/profile
                        echo $JFROG_HOME

                - configure

                        for testing, keep default
                        $JFROG_HOME/artifactory/var/etc/system.yaml - https://www.jfrog.com/confluence/display/JFROG/Artifactory+YAML+Configuration

                - start

                        artifactoryctl start
                        artifactoryctl check
                        artifactoryctl stop

                                - will not work under vpn
                                - start slow, need manual refresh

                - install as service

                        installService.sh [USER [GROUP]]
                        systemctl <start|stop|status> artifactory.service

                - visit

                        http://localhost:8082/ui/
                        default pass = User: admin, Password: password
                        for new pass, check secret.md

                - check log

                        tail -f $JFROG_HOME/artifactory/var/log/console.log

                - add licence
                
                        https://www.jfrog.com/confluence/display/JFROG/Managing+Licenses

        - mac (tested with old mac, no for M1)

                - install

                        https://jfrog.com/download-jfrog-platform/ (failed, too slow)

                        https://bintray.com/jfrog/product/JFrog-Artifactory-Pro/view
                        wget https://bintray.com/jfrog/artifactory-pro/download_file?file_path=org%2Fartifactory%2Fpro%2Fjfrog-artifactory-pro%2F7.12.6%2Fjfrog-artifactory-pro-7.12.6-darwin.tar.gz -O ./jfrog-artifactory-pro-7.12.6-darwin.tar.gz

                        sudo mkdir -p /opt/jfrog
                        sudo chown kyle:staff /opt/jfrog/

                        mv ~/Downloads/jfrog-artifactory-pro-7.12.6-darwin.tar.gz /opt/jfrog
                        cd /opt/jfrog
                        tar -xvf jfrog-artifactory-pro-7.12.6-darwin.tar.gz
                        mv jfrog-artifactory-pro-7.12.6 artifactory
                        chmod -R 777 ./artifactory/var

                        sudo vi /etc/profile
                        export JFROG_HOME=/opt/jfrog
                        export PATH=$PATH:$JFROG_HOME/artifactory/app/bin
                        source /etc/profile
                        echo $JFROG_HOME

                - configure

                        for testing, keep default
                        $JFROG_HOME/artifactory/var/etc/system.yaml - https://www.jfrog.com/confluence/display/JFROG/Artifactory+YAML+Configuration

                - start

                        artifactoryctl start
                        artifactoryctl check
                        artifactoryctl stop

                                - will not work under vpn
                                - start slow, need manual refresh
                                - mac M1
                                ERROR: CPU architecture arm64 is not supported

                - visit

                        http://localhost:8082/ui/
                        default pass = admin/password
                        base url=http://art_public_ip:8082

                - check log
                
                        tail -f $JFROG_HOME/artifactory/var/log/console.log

                - add licence
                
                        https://www.jfrog.com/confluence/display/JFROG/Managing+Licenses

- xray

        - rpm (tested for E+ install, qilin x86 = Linux distribution type not support)

                - install by rpm package (.rpm.tar.gz file)
                
                        wget https://releases.jfrog.io/artifactory/jfrog-xray/xray-rpm/3.47.3/jfrog-xray-3.47.3-rpm.tar.gz

                        tar zxf jfrog-xray-3.47.3-rpm.tar.gz

                        cd jfrog-xray-3.47.3-rpm

                        ./install.sh

                                Installation Directory (Default: /var/opt/jfrog/xray): 
                                JFrog URL: http://art_public_ip:8082	-> Admin -> Security -> Settings
                                Join Key: joinkey > art > admin > user management > settings > unlock!
                                Please specify the IP address of this machine (Default: 172.26.173.168): 172.26.173.168 
                                Are you adding an additional node to an existing product cluster? [y/N]:N 
                                Do you want to install PostgreSQL? [Y/n]:Y
                                database password: postgres (sample)
                                confirm database password: 

                                - error
                                wrong join key

                                - fix
                                vi /opt/jfrog/xray/var/etc/system.yaml
                                remove join key's value -> ./install.sh again

                - if install xray on the same VM of artifactory (tested ok)

                        1. first change artifactory's port 8081,8082,8046,8047,8049 to e.g. 9091...
                        2. vi /opt/jfrog/xray/var/etc/system.yaml > add node's id
                        because the default hostname will be used as id, which is already used by artifactory

                        shared
                            node:
                                ip: 172.21.119.182
                                id: xray

                - start
                
                        systemctl start xray

                - check log
                
                        tail -f /var/opt/jfrog/xray/log/console.log

                        - node id conflict error
                        Cluster join: Error during cluster join: Error response from service registry, status code: 409; 
                        message: Requested Router Join for nodeId: iZ8vb89qv0guht80htwwx8Z at: 39.101.198.27 conflicts (node id) with existing node: ServiceNodeImpl(serviceId=jffe@000, nodeId=iZ8vb89qv0guht80htwwx8Z, routerId=iZ8vb89qv0guht80htwwx8Z, state=HEALTHY, created=1614313068870, lastUpdated=1614313068870, version=null, revision=null, ip=172.26.116.242, endpoints=[EndpointImpl(port=9082, secure=false, paths=[/ui/(.*), /ui, /])]); Retrying...

                        - error of dirty server?
                        Cluster join: Failed joining the cluster; Error: Error response from service registry, status code: 400; message: Could not validate router Check-url: http://172.26.116.244:8082/router/api/v1/system/ping; detail: I/O error on GET request for "http://172.26.116.244:8082/router/api/v1/system/ping": Connect to 172.26.116.244:8082 [/172.26.116.244] failed: connect timed out; nested exception is org.apache.http.conn.ConnectTimeoutException: Connect to 172.26.116.244:8082 [/172.26.116.244] failed: connect timed out

                                - fix
                                could be caused by default hostnames conflict e.g. localhost
                                change system.yaml, set node id & ip

                        - error of jfrog-xray-3.27.3-rpm.tar.gz
                        2021-07-09T03:25:21.363Z [jfxr ] [INFO ] [                ] [access_client_bootstrap:167   ] [main                ] (--wrapper--)Cluster join: Retry 90: Service registry ping failed, will retry. Error: Error while trying to connect to local router at address 'http://localhost:8046/access': Failed to access :http://localhost:8046/access/api/v1/system/ping return status code : 503


                - visit
                
                        visit http://xray_ip:8082
                        
                        visit art page
                        add xray trial license

                - stop

                        kill postgre
                        kill rabbitmq
                        netstat -tulpn | grep :4369 (4369 used by rabbitmq)

        - docker compose (tested for HA install)

                - install docker compose
                
                        Docker v18 and above
                        Docker Compose v1.24 and up 

                - install
                
                        wget https://releases.jfrog.io/artifactory/jfrog-xray/xray-compose/3.48.2/jfrog-xray-3.48.2-compose.tar.gz

                        or
                        
                        wget https://bintray.com/jfrog/jfrog-xray/download_file?file_path=xray-compose%2F3.48.2%2Fjfrog-xray-3.48.2-compose.tar.gz

                        tar -xvf jfrog-xray-3.48.2-compose.tar.gz
                        cd jfrog-xray-3.48.2-compose/

                        (notice there is .env file)
                        This .env file is used by docker-compose and is updated during installations and upgrades.
                
                        ./config.sh (generate docker compose files for postgres/rabbitmq)

                                Installation Directory (Default: /root/.jfrog/xray):
                                JFrog URL: http://art_public_ip:8082
                                Join Key: joinkey > art > admin > user management > settings > unlock!
                                Please specify the IP address of this machine (Default: 172.26.173.168): 172.26.173.168 (local private ip)
                                Are you adding an additional node to an existing product cluster? [y/N]:N 
                                Do you want to install PostgreSQL? [Y/n]:Y
                                database password: postgres (sample)
                                confirm database password: 

                - if reinstall xray on the same VM (tested ok)
                        
                        kill postgre (installed by xray rpm pkg)
                        docker rm xray-postgre (created by xray docker compose)

                        kill rabbitmq (installed by xray rpm pkg)
                        netstat -tulpn | grep :4369 (4369 used by rabbitmq)

                        rm /root/.jfrog/xray/var/etc/system.yaml
                        rm ./installer.yaml (store config value)
                        ./config.sh (./docker-compose...yaml's content will be override)

                - if install xray on the same VM of artifactory (tested ok)

                        1. first change artifactory's port 8081,8082,8046,8047,8049 to e.g. 9091...
                        2. vi /root/.jfrog/xray/var/etc/system.yaml > add node's id
                        because the default hostname will be used as id, which is already used by artifactory

                        shared
                          node:
                              ip: 172.21.119.182
                              id: xray

                - start

                        docker-compose -p xray-rabbitmq -f docker-compose-rabbitmq.yaml up -d
                        docker-compose -p xray-postgres -f docker-compose-postgres.yaml up -d
                        docker-compose -p xray up -d
                        
                - check
                
                        docker-compose -p xray ps
                        docker-compose -p xray logs -f
                        tail -f -n 300 /root/.jfrog/xray/var/log/xray-server-service.log

                        - possible errors on dirty server
                        not reachable http://localhost:8046/access/api/v1/system/ping

                        Error connecting to rabbit message queue check mq settings. Error: dial tcp 172.17.18.103:5672: connect: network is unreachable

                        - fix
                        try on clean server
                        check log > check first error > check if join key error
                        vi /opt/jfrog/xray/var/etc/system.yaml > paste plain join key, once stared will be encryped

                - stop

                        docker-compose -p xray down
                        docker-compose -p xray-postgres -f docker-compose-postgres.yaml down
                        docker-compose -p xray-rabbitmq -f docker-compose-rabbitmq.yaml down

                - add license

                        visit art page
                        it will popup page to add xray trial license

                - if error, chmod: changing permissions of '/opt/jfrog/router/app/router/bin/jf-router-linux-amd64': Operation not permitted

                        - fix
                        vi docker-compose.yaml
                        add for each service: privileged: true

                - if error, cannot connect pg database

                        - fix
                        vi docker-compose.yaml
                        host_mode = host

                - if error, qilin x86 cannot connect rabbitmq

                        docker ps | grep rabbit
                        rabbitmq is restarting again & again

                        docker logs xxx
                        
                                - error
                                cookie file must be accessible by owner only

        - docker compose arm

                - install docker

                        wget https://download.docker.com/linux/static/stable/aarch64/docker-20.10.9.tgz
                        tar -zxvf docker-20.10.9.tgz
                        cp docker/* /usr/bin/          (/user/bin is in PATH, so dockerd can be found) 
                        dockerd &
                        docker run hello-world

                - install docker compose

                        curl -SL https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose

                - install xray

                        wget https://releases.jfrog.io/artifactory/jfrog-xray/xray-compose/3.71.7/jfrog-xray-3.71.7-compose.tar.gz
                        tar -zxvf jfrog-xray-3.71.7-compose.tar.gz
                        cd jfrog-xray-3.71.7-compose

                        ./config.sh (generate docker compose files for postgres/rabbitmq)

                                Installation Directory (Default: /root/.jfrog/xray):
                                JFrog URL: http://art_public_ip:8082
                                Join Key: joinkey > art > admin > user management > settings > unlock!
                                Please specify the IP address of this machine (Default: 172.26.173.168): 172.26.173.168 (local private ip)
                                Are you adding an additional node to an existing product cluster? [y/N]:N 
                                Do you want to install PostgreSQL? [Y/n]:Y
                                database password: postgres (sample)
                                confirm database password: 

                - start

                        docker-compose -p xray-rabbitmq -f docker-compose-rabbitmq.yaml up -d
                        docker-compose -p xray-postgres -f docker-compose-postgres.yaml up -d
                        docker-compose -p xray up -d
                        
                - check
                
                        docker-compose -p xray ps
                        docker-compose -p xray logs -f

                - stop

                        docker-compose -p xray down
                        docker-compose -p xray-postgres -f docker-compose-postgres.yaml down
                        docker-compose -p xray-rabbitmq -f docker-compose-rabbitmq.yaml down

                - add license

                        visit art page
                        it will popup page to add xray trial license

- jas

        - xray

                - install
                
                        wget https://releases.jfrog.io/artifactory/jfrog-xray/xray-rpm/3.73.8/jfrog-xray-3.73.8-rpm.tar.gz
                        tar zxf jfrog-xray-3.73.8-rpm.tar.gz
                        cd jfrog-xray-3.73.8-rpm
                        ./install.sh

                        postgre

                - [ERROR] Installing unixODBC package failed
                
                        https://forums.oracle.com/ords/apexds/post/error-when-trying-to-install-package-unixodbc-2-2-14-12-el6-3214
                        
                        wget https://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/yaf-1.3.2-1.el6.rf.x86_64.rpm
                        
                        rpm -ivh --nodeps yaf-1.3.2-1.el6.rf.x86_64.rpm

        - jas
                
                https://jfrog.com/help/r/jfrog-installation-setup-documentation/jas-manual-installation

                yum install epel-release
                yum install ansible

                vi k3s-ansible/inventory/k3scluster/hosts.in

                [master]
                10.90.184.25
                [node]
                10.90.122.151
                10.90.180.51
                [k3s_cluster:children]
                master
                node
                [all:vars]
                ansible_ssh_common_args='-o StrictHostKeyChecking=no'

                vi k3s-ansible/inventory/k3scluster/group_vars/all.yml
                ansible_user: root

                cd k3s-ansible
                ansible-playbook -v site.yml -i inventory/k3scluster/hosts.ini

                ...

                cp kube_config.yaml /opt/jfrog/xray/var/etc

                vi /opt/jfrog/xray/var/etc/system.yaml

                executionService:
                jobAesKey: <Your execution key > // openssl rand -hex 16
                kubeconfig:
                path: /opt/jfrog/xray/var/etc/kube_config.yaml
                namespace: default
                context: default
                enabled: true

                systemctl restart xray

- mission control

        - rpm (tested for E+ install)

                - install
                
                        wget https://releases.jfrog.io/artifactory/jfrog-mc/rpm/4.6.5/jfrog-mc-4.6.5-rpm.tar.gz
                        tar zxf jfrog-mc-4.6.5-rpm.tar.gz
                        cd jfrog-mc-4.6.5-rpm
                        ./install.sh

                                Installation Directory (Default: /var/opt/jfrog/mc): 
                                JFrog URL: http://art_public_ip:8082 joinkey > art > admin > user management > settings > unlock!
                                Join Key: Admin -> Security -> Settings
                                Please specify the IP address of this machine (Default: 172.26.173.169): 172.26.173.169 (private of this host)
                                Are you adding an additional node to an existing product cluster? [y/N]: N
                                Do you want to install PostgreSQL? [Y/n]:Y Y
                                database password: postgres (this is a sample)
                                confirm database password:
                                Do you want to install Elasticsearch? [Y/n]:Y
                                username/password = elasticsearch/elasticsearch (this is a sample)

                - start
               
                        systemctl start mc

                - check log
                
                        tail -f /var/opt/jfrog/mc/log/console.log

                - visit
                
                        visit art page
                        check mission dashboard

        - docker compose (tested for HA install)

                - install

                        wget https://releases.jfrog.io/artifactory/jfrog-mc/compose/4.7.2/jfrog-mc-4.7.2-compose.tar.gz
                        tar -zxvf ...
                        cd jfrog-mc-4.7.2-compose
                        ./config.sh

                - start

                        docker-compose -p mc-postgres -f docker-compose-postgres.yaml up -d
                        docker-compose -p mc up -d
                        docker-compose -p mc down

- distribution

        - rpm (tested for E+ install)

                - install

                        wget https://releases.jfrog.io/artifactory/jfrog-distribution/distribution-rpm/2.6.1/jfrog-distribution-2.6.1-rpm.tar.gz
                        tar zxf jfrog-distribution-2.6.1-rpm.tar.gz
                        cd jfrog-distribution-2.6.1-rpm
                        ./install.sh

                                Installation Directory (Default: /var/opt/jfrog/distribution): 
                                JFrog URL: http://art_public_ip:8082	-> 从Admin -> Security -> Settings
                                Join Key: -> 从Admin -> Security -> Settings
                                Please specify the IP address of this machine (Default: 172.26.173.170): 172.26.173.170 (local private ip)
                                Are you adding an additional node to an existing product cluster? [y/N]:N 
                                Do you want to install PostgreSQL? [Y/n]:Y 
                                database password: postgres (sample)
                                confirm database password:

                - start
                
                        systemctl start distribution

                - check log
                
                        tail -f /var/opt/jfrog/distribution/log/console.log

                - visit
                
                        visit art page
        
- edge

        - rpm (tested for E+ install)
        
                - install
                
                        same with art install

                - add trial licence
                
                        the only difference is the edge license

                - add edge node
                
                        art -> platform deployment -> register deployment
                        JFrog URL: http://art_public_ip:8082	-> 从Admin -> Security -> Settings
                        Join Key: -> 从Admin -> Security -> Settings

                - add E+ license bucket
                
                        art -> license -> add the 2 json(for 6 + 5 nodes) licence downloaded from E+ trial link

- pgp key for distribution to work

        - centos tool for quick pgp key generation
        
                yum install -y rng-tools
                systemctl enable rngd
                systemctl restart rngd

        - generate pgp key
        
                gpg --gen-key
                
                        RSA and RSA (default)
                        What keysize do you want? (2048) 
                        ...
                        Real name: zhangsan
                        Email address: zhangsan@example.com
                        Comment: zhangsan

                        password=xxx  (will be used to crate & sign release bundles)

        - export

                gpg --output ./private.key --armor --export-secret-keys zhangsan
                gpg --output ./public.key --armor --export zhangsan

        - send key to distribution
        
                touch gpg.json (refer to https://www.jfrog.com/confluence/display/JFROG/Distribution+REST+API#DistributionRESTAPI-UploadGPGSigningKeyforDistribution)
                
                check gpg.json

        - upload to distribution
        
                curl -uadmin:xxx -H "Accept: application/json" -H "Content-Type: application/json" -X PUT "http://distribution_public_ip:8082/distribution/api/v1/keys/gpg" -T gpg.json

        - add public key to artifactory & edge
        
                art -> Trusted Keys -> upload public key
                edge -> Trusted Keys -> upload public key

        - send root.crt from art to edge
        
                login art
                scp -r /var/opt/jfrog/artifactory/etc/access/keys/root.crt root@39.101.205.237:/var/opt/jfrog/artifactory/etc/access/keys/trusted/
                
                login edge
                chown -R artifactory:artifactory /var/opt/jfrog/artifactory/etc/access/keys/trusted/root.crt

                wait 10 sec for root.crt to disppear

        - send root.crt from edge to art
        
                login edge
                scp -r /var/opt/jfrog/artifactory/etc/access/keys/root.crt root@39.101.205.251:/var/opt/jfrog/artifactory/etc/access/keys/trusted/

                login art
                chown -R artifactory:artifactory /var/opt/jfrog/artifactory/etc/access/keys/trusted/root.crt

                wait 10 sec for root.crt to disppear
                
- p2p

        - guide
        
                https://www.jfrog.com/confluence/display/JFROG/JFrog+Peer-to-Peer+%28P2P%29+Downloads

        - enable p2p
        
                - login art node
                vi /opt/jfrog/artifactory/var/etc/system.yaml
                
                        - error
                        do not use restart
                        
                        - fix
                        if cannot start art, stop all other nodes, kill all process of art, and start art

                systemctl stop artifactory
                systemctl start artifactory

                - login edge node
                vi /opt/jfrog/artifactory/var/etc/system.yaml
                systemctl stop artifactory
                systemctl start artifactory

        - install peer node

                - copy p2p access token from edge node
                security -> settings -> p2p access token
                e.g. 9fc22fc3da40d32fe5b7d95705270cf3

                - login peer node (e.g. mission node)
                vi /etc/profile.d/jfrog.sh
                source /etc/profile.d/jfrog.sh

                - login art node
                find / -iname p2p 2>/dev/null
                scp -r /opt/jfrog/artifactory/app/replicator/p2p/jfrog-p2p-client.zip root@47.93.99.107:/opt/

                - login peer node
                yum install -y unzip
                cd /opt
                unzip jfrog-p2p-client.zip
                mkdir -p /opt/var/etc/
                vi /opt/var/etc/system.yaml
                cd /opt/p2p-client/bin
                chmod a+x *

                - start peer
                nohup ./p2p-client-linux-amd64 > peer_service.log 2>&1 &

                - check log
                tail -f /opt/p2p-client/bin/peer_service.log

                - check peer status
                edge node -> monitoring -> p2p download

        - config docker proxy (on a docker client node, could be peer node)
        
                - login docker clint node
                mkdir -p /etc/systemd/system/docker.service.d
                vi /etc/systemd/system/docker.service.d/http-proxy.conf  (use ip of peer node)

                - update insecure registry
                vi /etc/docker/daemon.json

                systemctl daemon-reload
                systemctl restart docker

                - check
                systemctl show --property=Environment docker

        - test docker download

                - upload docker image to art from local
                update insecure registry
                docker pull hello-world
                docker login -u admin 47.93.221.201:8082
                docker tag hello-world 47.93.221.201:8082/docker-local/hello-world
                docker push 47.93.221.201:8082/docker-local/hello-world

                - distribute to edge node

                - login the docker client node, pull from edge node (ip_of_edge:8089)
                docker login -u admin 8.140.179.156:8089
                docker pull 8.140.179.156:8089/docker-local/hello-world

                - check peer status
                edge node -> monitoring -> p2p download

                - monitor log
                tail -f /opt/p2p-client/bin/peer_service.log

                - check download log
                tail /opt/p2p-client/bin/peer_service.log -n 10000 | grep download
                e.g.
                ... Finalizing /opt/var/data/peer/watch/docker-local/hello-world/_uploads/sha256__a29f45ccde2ac0bde957b1277b1501f471960c8ca49f1588c6c885941640ae60.downloading piece #0 from 8.140.179.156:8852@iZ2ze6gybozdaaerhwsw0uZ; event processed in 208.095µs; write pos 9.275µs; save piece 130.19µs; send data: 76.904µs [splicer_service]

                ...
                sending data to client 47.93.99.237:43422 successfully

        - test binary download

                use api & access token

                - download directly from peer node
                curl -O -H "Authorization: Bearer xxx" http://xxx:8089/api/v1/peer/download/generic-local/volvo/xxx.txt

                - download from edge node, use peer as proxy
                curl -O "Authorization: Bearer xxx" --proxy http://ip_of_peer:8089 http://ip_of_edge:8082/api/v1/peer/download/generic-local/volvo/volare_require.txt
                
- jfrog platform helm chart

        - storage / pv

                - filesystem
                        
                        - delete
                        use default storageclass, but reclaimpolicy could be DELETE, then data gone

                        - retain, dynamatic
                        create storageClassName e.g. efs-sc , reclaimpolicy = RETAIN
                        set PVC related setting in values.yaml, PVC create PV automatically
                        
                        - retain, static
                        manually create PV, set existingxxx in values.yaml
                        e.g.
                        csi: 
                                driver: efs.csi.aws.com
                                volumeHandle: fs-xxx

                - nfs (easy for HA)

                        - nfs server
                        ip=xxx
                        dataDir=xxx

                        - nfs provider created storageclass

                - fs/nfs + S3
                
                        e.g. aws, azure blob ...

        - install helm & add repo

                helm repo add center https://repo.chartcenter.io
                helm repo update

        - install nfs & provider
        
                if you miss this, you have to delete all pv, pvc, folder and use another mount folder

                install nfs at /data (linux/common/nfs.md)
                ./install_nfs_provider.sh (create default nfs storageclass)

                make sure provider's pod is ready, if not, check the pod's event or kubectl describe pod xxx
                if it's pending on pull image, pull it on every node, uninstall provider and install again

        - reconfigure api server, why?
        
                vi etc/kubernetes/manifests/kube-apiserver.yaml
                e.g.
                - --feature-gates=RemoveSelfLink=false
                kubectl delete pod/kube-apiserver-master -n kube-system

        - install platform (this chart uses nfs provider)
       
                helm upgrade --install jfrog-platform center/jfrog/jfrog-platform -f custom-values.yaml

                - check log
                k8s_install_art.log

                - check status of pod
                kubectl describe pod xxx
        
                - error
                pod has unbound immediate PersistentVolumeClaims

                - fix
                helm uninstall jfrog-platform
                helm uninstall mynfs
                yum install -y nfs-utils (ever node)
                sometimes delete pod and see if it works

        - or install art (this chart does not use the nfs provider)
        
                helm upgrade --install jfrog-platform center/jfrog/artifactory

        - uninstall
        
                helm uninstall jfrog-platform

        - visit
        
                edit Service jfrog-platform-nginx
                LoadBalancer -> NodePort
                ssh tunnel = 127.0.0.1 8000 -> 10.1.228.249 31037

                http://localhost:8000/ui/login/


