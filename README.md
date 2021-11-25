
# artifactory　中文插件


- 安装步骤

        1. 上传中文插件 chinese.js 到 Artifactory 前端 UI 的安装目录下
        例如 /opt/jfrog/artifactory/app/frontend/bin/client/dist/js/chinese.js

        2. 修改 Artifactory 前端 UI 的 index.html，引用 chinese.js
        例如先下载 /opt/jfrog/artifactory/app/frontend/bin/client/dist/index.html
        将 <link href=/ui/js/chinese.js rel=preload as=script> 和 <script src=/ui/js/chinese.js></script> 添加进 index.html
        具体添加位置可参考本代码库中的 index.html， 然后回传到服务器上

- 使用步骤

        1. 登录 Artifactory
        2. 需要翻译时， 点击右上角的 中文 进行翻译， 点击 英文 切换回来
        3. 如果不想手动点击， 可以修改 chinese.js 中， 选择其中使用方式2， 进行持续自动翻译

- 效果截图

    ![image info](./images/1.png)
    ![image info](./images/2.png)
        






