
# jfrog ui plugins

- why

        1. localization / 本地化
        2. custom UI / 定制化
        3. curation / 引入流程

- what

        1. native UI API accessible out of box (via cookie, no need to change URL)
        2. easy accessible JFROG REST API with managed access token
        3. no need to manage users/permissions, as permissions consistent with your login user
        4. no need to have backend program, use your favorite html/js framework directly talking to jfrog API

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


        



