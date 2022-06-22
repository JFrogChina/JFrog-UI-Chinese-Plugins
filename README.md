
# jfrog ui plugins

- why

        1. localization / 本地化
        2. custom UI / 定制化
        3. curation / 引入流程
        
        you can imageine ...

- how

        1. hack UI e.g. use Chinese
        2. native UI API accessible out of box (via cookie, no need to change URL)
        3. JFROG REST API accessible with builtin auth - managed access token
        4. no backend program, use your favorite html/js framework directly talking to jfrog API
        5. no users/permissions management, as permissions are consistent with your login user

- install

        1. upload plugins to Artifactory's frontend's folder
        e.g. /opt/jfrog/artifactory/app/frontend/bin/client/dist/plugins

        2. edit Artifactory's frontend's index.html, include plugins.js
        
        e.g. download /opt/jfrog/artifactory/app/frontend/bin/client/dist/index.html
        edit index.html, add below links
        
        <link href=/ui/plugins/plugins.js rel=preload as=script>
        <script type="module" src=/ui/plugins/plugins.js></script> into index.html
        
        refer to index.html in this github repo to make sure position correct
        3. then upload index.html back to server

- chinese plugin

        1. login Artifactory
        2. to translate, click '中文', click 'English' to switch back to English
        3. if not willing to click manually, edit plugins.js, change code to enable auto translation

        screenshots as below

    ![image info](./images/1.png)
    ![image info](./images/2.png)
        
- plugins list

        1. login Artifactory
        2. click 'UI Plugins'

    ![image info](./images/3.png)
    ![image info](./images/4.png)


        



