# cli

- guide

        - instal
        
                - guide
                https://www.jfrog.com/confluence/display/CLI/JFrog+CLI

                - download
                https://jfrog.com/getcli/

        - artifactory usage
        
                https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory

        - xray usage
        
                https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Xray


- install

        - jfrog cli v2, use jf ...
        
                curl -fL https://install-cli.jfrog.io | sh
                jf -version
                e.g. jf version 2.16.2 
                
        - jfrog cli v2, use jfrog ...

                curl -fL https://getcli.jfrog.io/v2 | sh
                mv jfrog /usr/local/bin

- auth

        1. by config

                - v2 

                        jf config add / jf c add

                        art-china = enter
                        jfrog url = https://demo.jfrogchina.com/
                        access token = input access token / leave blank to coninue to input username/password
                        username = kyle
                        password or api key = password or get api key from artifactory > up right > profile
                        Is the Artifactory reverse proxy configured to accept a client certificate? (y/n) [n]? = enter

                - v1 only
                
                        jfrog rt config
                
                - check
                        
                        jf rt ping
                        jf c show
                        jf c use art-china
                        jf c use art-china-public
                        jf rt s "app1-maven-release-local/*.war"

                        - help
                        jf -help
                        jfrog rt mvn -help

                - config details (optional to understand)

                        - check .jfrog/jfrog-cli.conf.v4
                        - access token = JWT token (including access scope, expiry time, issue time)

                                e.g.
                                eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJzZTFvSmtYUGRNWGk0MmtxQ2JjNklLa2xNOUF2eFRKX09jRUNFbEJQN0VjIn0.eyJzdWIiOiJqZnJ0QDAxZTZ0cHRnOHA5cHZqMGRuMGcyNGgxaDdiXC91c2Vyc1wvYWRtaW4iLCJzY3AiOiJtZW1iZXItb2YtZ3JvdXBzOiogYXBpOioiLCJhdWQiOiJqZnJ0QDAxZTZ0cHRnOHA5cHZqMGRuMGcyNGgxaDdiIiwiaXNzIjoiamZydEAwMWU2dHB0ZzhwOXB2ajBkbjBnMjRoMWg3YlwvdXNlcnNcL2FkbWluIiwiZXhwIjoxNjE1NDc4MDEyLCJpYXQiOjE2MTU0NzQ0MTIsImp0aSI6IjYxY2NlZjhmLTNjZjctNDA5ZS1iODUxLWI1YzA5NzdiZWI1ZSJ9.Dh26AN9rzGtfngUlLSTMeRyN4OyaZq3yjM3TktKB9G2XdHaefwDdj58mo0lM6uN45gI44lzlfMbsF_GoYoi6VU9ni3bFAoTnxCUgFObJ3z8_zxmRHV7YWraNkk7CjD3RhOJ9vbbzqaO2XlFlfuwrIupoZcLXVT82n6YYCpBZ6xtnTYUFAJeSGrqzlgR_B__GegW4SeVJKFONkknCwcIJSj39zcJKYDORIguNiWib0xfRnOmpscqWGJhIDi5eGbD5q-vxL5nBlL7LS25-xA41BdOwoKfEs-VL0DKT7Xb83j8eznHbLg_lhR_GNIa-nziadpvlKYElwUyWXvzDGNBX4A

                        - decode token online
                                
                                https://www.jsonwebtoken.io/

                        - decode by base64

                                - decode token header

                                        e.g. 
                                        echo "eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJzZTFvSmtYUGRNWGk0MmtxQ2JjNklLa2xNOUF2eFRKX09jRUNFbEJQN0VjIn0" | base64 -D

                                        header = {
                                                "typ": "JWT",
                                                "alg": "RS256",
                                                "ver": "2",
                                                "kid": "se1oJkXPdMXi42kqCbc6IKklM9AvxTJ_OcECElBP7Ec"
                                                }

                                - decode token payload

                                        echo "eyJzdWIiOiJqZnJ0QDAxZTZ0cHRnOHA5cHZqMGRuMGcyNGgxaDdiXC91c2Vyc1wvYWRtaW4iLCJzY3AiOiJtZW1iZXItb2YtZ3JvdXBzOiogYXBpOioiLCJhdWQiOiJqZnJ0QDAxZTZ0cHRnOHA5cHZqMGRuMGcyNGgxaDdiIiwiaXNzIjoiamZydEAwMWU2dHB0ZzhwOXB2ajBkbjBnMjRoMWg3YlwvdXNlcnNcL2FkbWluIiwiZXhwIjoxNjE1NDc4MDEyLCJpYXQiOjE2MTU0NzQ0MTIsImp0aSI6IjYxY2NlZjhmLTNjZjctNDA5ZS1iODUxLWI1YzA5NzdiZWI1ZSJ9" | base64 -D

                                        payload = {
                                                "sub": "jfrt@01e6tptg8p9pvj0dn0g24h1h7b/users/admin",
                                                "scp": "member-of-groups:* api:*",
                                                "aud": "jfrt@01e6tptg8p9pvj0dn0g24h1h7b",
                                                "iss": "jfrt@01e6tptg8p9pvj0dn0g24h1h7b/users/admin",
                                                "exp": 1615478012,
                                                "iat": 1615474412,
                                                "jti": "61ccef8f-3cf7-409e-b851-b5c0977beb5e"
                                                }

        2. by param

                - pass

                        --url=https://demo.jfrogchina.com/artifactory --user=kyle --password=xxx
                        --url=https://demo.jfrogchina.com/xray --user=kyle --password=xxx

                - token
                
                        --url=xxx --access-token=xxx

- manage files

        - upload

                jf rt u "./*" app1-generic-dev-local/tmp/ --recursive=true --flat=false 

        - download

                - download to ./tmp/
                jf rt dl app1-generic-dev-local/tmp/ tmp/

                - download latest
                jf rt dl "app1-generic-dev-local/tmp/" --sort-by=created --sort-order=desc --limit=1

                - set threads
                --threads=3

        - copy

                - copy all under folder tmp to tmp1
                jf rt cp app1-generic-dev-local/tmp/* app1-generic-dev-local/tmp1/

                e.g.
                Copying artifact: app1-generic-dev-local/tmp/file.txt to: app1-generic-dev-local/tmp1/tmp/file.txt

                - copy by properties
                jf rt cp app1-generic-dev-local/metaverse/hero/* app1-generic-dev-local/tmp1/ --props=version=v1.1.1

                e.g.
                Copying artifact: app1-generic-dev-local/metaverse/hero/52445e5c506a510a750c05928900502f.jpg to: app1-generic-dev-local/tmp1/metaverse/hero/52445e5c506a510a750c05928900502f.jpg

        - move

                jf rt mv app1-generic-dev-local/tmp/ app1-generic-dev-local/tmp1/

        - delete

                jf rt del app1-generic-dev-local/tmp/

        - search

                jf rt s "app1-maven-snapshot-local/*.war" --build=maven-cli-build/2

        - search by file sepc (set cli command options in file)

                - search by pattern
                jf rt s --spec search-by-pattern.json

                - search by aql
                jf rt s --spec search-by-aql.json

        - set properties

                jf rt sp "app1-generic-dev-local/tmp/" "a=1;b=2,3"

        - delete properties
        - create access token for a user
        - jfrog curl

                jf rt curl -XGET /api/build

- build integration

        - publish generic artifacts + build info

                e.g. ant project
                
                - clone
                
                        cd ant-example

                        mkdir build
                        touch build/1.zip
                        touch build/2.zip

                        mkdir libs
                        touch libs/1.jar
                        touch libs/2.jar
                        
                        mkdir module1
                        touch module1/m1.zip

                - collect env

                        jf rt bce ant-cli-build 1

                - collect git

                        jf rt bag ant-cli-build 1
                        jf rt bag ant-cli-build 1 --config=jira-cli.conf

                - add deps

                        bad = build-add-dependencies, Adding Local Files As Build Dependencies
                        jf rt bad ant-cli-build 1 "libs/"  (ending / is a must)

                - build

                        e.g. ant build

                - upload artfact

                        - all files located under the build directory
                        jf rt u "build/" app1-generic-dev-local/kyle/ --build-name=ant-cli-build --build-number=1

                        - add module
                        jf rt u "module1/*.zip" app1-generic-dev-local --build-name ant-cli-build --build-number 1 --module m1

                - publish build info 
                
                        jf rt bp ant-cli-build 1

        - publish maven

                - prepare

                        install cli
                        export M2_HOME=/opt/apache-maven-3.6.0
                        
                - clone

                        git clone https://github.com/kyle11235/maven-example.git
                        cd maven-example

                - config art repos for this project
                
                        jf mvnc (interactively add .jfrog/projects/maven.yaml)

                - collect env (optional)
                
                        jf rt bce maven-cli-build 1 // collect environment variables and attach them to a build
                                        
                - add deps & build
                
                        jf mvn clean install --build-name=maven-cli-build --build-number=1

                                - error downloading jfrog maven build info extractor
                                plugin download failed for no access to jcenter

                                - fix
                                https://www.jfrog.com/confluence/display/CLI/CLI+for+JFrog+Artifactory#CLIforJFrogArtifactory-DownloadingtheMavenandGradleExtractorJARs
                                JFROG_CLI_JCENTER_REMOTE_SERVER=art-china
                                JFROG_CLI_JCENTER_REMOTE_REPO=repo_name_in_artifactory

                                - fix1
                                check downloaded software/build_info_extractor

                - upload

                        Artifacts deployment to Artifactory is triggered by the install phase (and not the deploy phase).
                        to change it
                        e.g. "clean install -Dartifactory.publish.artifacts=false"

                - publish build info 

                        jf rt bp maven-cli-build 1
                        (no conflict using the same build number)

                - promote build

                        jf rt bpr maven-cli-build 1 libs-stage-local --status=Staged --comment="promote test" --copy=true

        - publish maven in gitlab docker, linux cli installed

                - config
                check maven.conf

                - build (maven.conf does not work on mac)
                jf rt mvn "clean install" maven.conf --build-name=maven-cli-build --build-number=1

        - publish npm

                - clone

                        git clone https://github.com/kyle11235/npm-examples

                - config
                
                        jf rt npmc (add .jfrog/projects/npm.yaml for resolution & deplpyment)

                - add deps (npm install)

                        jf rt npmci --build-name=npm-cli-build --build-number=1

                - upload (npm publish a module)

                        jf rt npmp --build-name=npm-cli-build --build-number=1

                - publish build info

                        jf rt bp npm-cli-build 1

        - publish python

                check jenkins.md, actually use cli

        - publish docker

                - clone

                        git clone https://github.com/jfrog/project-examples
                        cd project-examples/jenkins-examples/pipeline-examples/resources
                        
                - config

                        docker login -u admin 182.92.214.141:8082

                - add build deps (docker layers) by pull/push

                        - pull (collect layers)
                        jf rt dpl 182.92.214.141:8082/docker-dev-local/docker-cli-build:latest docker-dev-local --build-name=cli-docker-build --build-number=1

                - build

                        docker build -t 182.92.214.141:8082/docker-dev-local/cli-docker-build .

                - upload

                        - push (collect layers)
                        jf rt dp 182.92.214.141:8082/docker-dev-local/docker-cli-build:latest docker-dev-local --build-name=cli-docker-build --build-number=1

                - publish build info

                        jf rt bp cli-docker-build 1

                - promote

                        dpr = docker-promote
                        jf rt dpr cli-docker-build docker-dev-local docker-prod-local (default is move, not copy)

                        - no release history?
                        jf rt dpr cli-docker-build docker-dev-local docker-prod-local --source-tag=latest --target-tag=latest --copy=true

        - append build info / link build together (no use at all)

                jf rt build-append aggregating-build 10 ant-cli-build 1
                jf rt build-append aggregating-build 10 maven-cli-build 1
                jf rt build-publish aggregating-build 10

        - scan build

                jf rt bs cli-maven-build 1
                (Build cli-maven-build is not selected for indexing)

        - discard old builds

                - keep 10 builds
                jf rt bdi cli-maven-build --max-builds=10

                - keep within 7 days
                jf rt bdi cli-maven-build --max-days=7

- xray scan binary

        - war
        jf s /Users/kyle/workspace/maven-example/multi3/target/*.war --watches "app1-watch"

        - folder
        jf s /Users/kyle/workspace/maven-example/multi3/target/ --watches "app1-watch"

        - auth
        jf s /Users/kyle/workspace/maven-example/multi3/target/ --watches "app1-watch" --url=https://demo.jfrogchina.com/xray --user=kyle --password=xxx

- xray aduit dependencies

        cd /Users/kyle/workspace/maven-example
        jf audit --mvn

- manage resources

        - users and groups
        - repositories
        - replications
        - release bunndles



                








