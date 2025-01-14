
# JFrog UI Plugins

- why

        1. localization / 本地化
        2. custom UI / 定制化
        3. you can imagine ...
        
        - new feature request

                - Customer would like a UI feature to delete unused or old Artifacts similar to CleanUp Plugin
                https://www.jfrog.com/jira/browse/RTFACT-26239

                - AQL GUI
                https://www.jfrog.com/jira/browse/RTFACT-8525

                - Add the Ability to Download Multiple Files at a Time via a Search
                https://www.jfrog.com/jira/browse/RTFACT-26894

                - Customer Defined Documentation
                https://www.jfrog.com/jira/browse/RTFACT-26389

                - Package Search by Build
                https://www.jfrog.com/jira/projects/JUX/issues/JUX-50

                - Providing statistics, visibility and analytics for D2D usage and security
                https://www.jfrog.com/jira/projects/JUX/issues/JUX-35

- how

    ![image info](./images/design/Slide1.png)
    ![image info](./images/design/Slide2.png)

- install

        1. upload plugins to Artifactory's frontend's folder
        
                e.g. /opt/jfrog/artifactory/app/frontend/bin/client/dist/plugins

        2. update Artifactory's frontend's index.html, include plugins.js
        
                e.g. download /opt/jfrog/artifactory/app/frontend/bin/client/dist/index.html
                edit index.html, add below links
                
                <link href=/ui/plugins/plugins.js rel=preload as=script>
                <script type="module" src=/ui/plugins/plugins.js></script> into index.html
                
                refer to index.html in this github repo to make sure position correct

        3. then upload index.html back to server

- install (for k8s pod)

        1. ssh
        
                kubectl get pods -n artifactory
                kubectl exec --stdin --tty artifactory-0 -n artifactory -- /bin/bash
                cd /opt/jfrog/artifactory/app/frontend/bin/client/dist
                mv index.html index.html.bak
                cat index.html.bak
                exit

        2. update according to index.html.bak
        
                git clone https://github.com/kyle11235/jfrog-ui-plugins
                vi ./jfrog-ui-plugins/index.html
                
                refer to index.html in this github repo to make sure position correct

        3. cp will overwrite
        
                kubectl cp ./jfrog-ui-plugins/index.html artifactory/artifactory-0:/opt/jfrog/artifactory/app/frontend/bin/client/dist
                
                kubectl cp ./jfrog-ui-plugins/plugins artifactory/artifactory-0:/opt/jfrog/artifactory/app/frontend/bin/client/dist

- plugins list

        1. login Artifactory
        2. click 'UI Plugins'

    ![image info](./images/plugin_button.png)
    ![image info](./images/plugin_list.png)

- i18n plugin

        1. login Artifactory
        2. to translate, click '中文', click 'En' to switch back to English

    Chinese
    ![image info](./images/cn.png)

    French
    ![image info](./images/fr.png)

    Japanese
    ![image info](./images/ja.png)

- cleanup plugin

    ![image info](./images/clean.png)


        



