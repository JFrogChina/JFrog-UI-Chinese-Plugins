
# jfrog ui plugins

- install

        1. upload plugins to Artifactory's frontend's folder
        e.g. /opt/jfrog/artifactory/app/frontend/bin/client/dist/plugins

        2. edit Artifactory's frontend's index.html, include plugins.js
        
        e.g. download /opt/jfrog/artifactory/app/frontend/bin/client/dist/index.html
        edit index.html, add below links
        
        <link href=/ui/plugins/plugins.js rel=preload as=script>
        <script type="module" src=/ui/plugins/plugins.js></script> into index.html
        
        refer to index.html in this github repo to make sure position correct
        then upload index.html back to server

- chinese plugin

        1. login Artifactory
        2. to translate, click 中文, click 英文 to switch back to English
        3. if not willing to click manually, edit chinese.js, change code to translate automatically

        screenshots as below

    ![image info](./images/1.png)
    ![image info](./images/2.png)
        
- demo plugin

        1. login Artifactory
        2. visit http://x.x.x.x:8082/ui/plugins/demo/

        easy to call UI API
        easy to call REST API
        no need to manage permissions

        - todo
        secure encrypted password

        



