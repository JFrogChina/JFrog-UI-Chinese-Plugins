
var myMap = myMap || {

    "Welcome" : "欢迎光临",
    "Happily serving" : "正在管理",
    "artifacts" : "制品",
    "Filter by" : "过滤条件",
    "Sort by" : "排序",
    "My Favorites" : "我的收藏",
    "Tree View" : "树形视图",
    "Set Me Up" : "设置指引",
    "Deploy" : "部署",


    "Application" : "应用",

    "Dashboard" : "工作台",
    "Topology" : "拓扑",
    "Trends" : "趋势",

    "Artifactory" : "制品库",
    "Packages" : "包",
    "Builds" : "构建",
    "Artifacts" : "制品",
    
    "Distribution" : "分发",

    "Pipelines" : "流水线",
    "My Pipelines" : "我的流水线",
    "Integrations" : "集成",
    "Pipeline Sources" : "流水线资源",
    "Node Pools" : "节点池",
    "Extensions & Templates" : "扩展 & 模版",

    "Security & Compliance" : "安全 & 合规",
    "Watch Violations" : "监控违反",
    "Report" : "报告",

    "General" : "通用",
    "Info" : "信息",
    "Name" : "名称",
    "Repository Path" : "仓库路径",
    "URL to file" : "文件 URL",
    "Deployed By" : "发布人",
    "Size" : "大小",
    "Created" : "创建时间",
    "Last Modified" : "最后修改时间",
    "Downloads" : "下载次数",
    "Last Downloaded By" : "最后下载人",
    "Last Downloaded" : "最后下载时间",
    "Remote Downloads" : "远程下载次数",
    "Filtered" : "过滤的",
    "Virtual Repository Associations" : "关联的虚拟仓库",
    "Included Repositories" : "包含的仓库",
    "Checksums" : "校验值",
    "Dependency Declaration" : "依赖声明",
    "Build Tool" : "构建工具",

    "Violations" : "违反",
    "Security" : "安全",
    "Licenses" : "许可证",
    "Descendants" : "子级",
    "Ancestors" : "父级",
    "Actions" : "操作",
    "Violation Status" : "违反状态",
    "Summary" : "总览",
    "Severity" : "严重性",
    "Watch Name" : "监控名称",
    "Type" : "类型",
    "Component" : "组件",
    "Policies" : "策略",


    "Effective Permissions" : "生效的权限",
    "Properties" : "属性",
    "Followers" : "关注者",


    "Administration" : "管理",
    "Projects" : "项目",
    "Repositories" : "仓库",
    "Layouts" : "布局",
    "Identity and Access" : "身份和认证",
    "Users" : "用户",
    "Groups" : "用户组",
    "Global Roles" : "全局角色",
    "Permissions" : "权限",
    "Access Tokens" : "访问凭证",
    "Settings" : "设置",
    "License" : "许可证",
    "Activate Xray" : "激活 Xray",
    "Mail Server" : "邮件服务器",
    "Proxies" : "代理",
    "Configuration" : "配置",
    "Monitoring" : "监控",
    "Storage" : "存储",
    "Service Status" : "服务状态",
    "System Logs" : "系统日志",
    "Support Zone" : "支持区域",
    "SERVICES" : "服务",

}

function replaceInText(element, pattern, replacement) {
    for (let node of element.childNodes) {
        switch (node.nodeType) {
            case Node.ELEMENT_NODE:
                replaceInText(node, pattern, replacement);
                break;
            case Node.TEXT_NODE:
                node.textContent = node.textContent.replace(pattern, replacement);
                break;
            case Node.DOCUMENT_NODE:
                replaceInText(node, pattern, replacement);
        }
    }
}

// replaceInText(document.body, /Artifactory/g, '制品库');

function translate(back = false){

    var i;
    for(i in myMap){
        let regex;
        if(!back){
            console.log(i + '=' + myMap[i]);
            regex = new RegExp('' + i + '', 'g');
            replaceInText(document.body, regex, myMap[i]);
        } else {
            console.log(myMap[i] + '=' + i);
            regex = new RegExp('' + myMap[i] + '', 'g');
            replaceInText(document.body, regex, i);
        }
    }

};

function addButton(){

    var arr = document.getElementsByClassName("help-container");

    var button1 = document.createElement('span');
    button1.style.width = '50px';
    button1.style.textAlign = 'center';
    var linkText = document.createTextNode("中文");
    button1.appendChild(linkText);
    button1.addEventListener('click', function(){ translate() });
    arr[0].appendChild(button1);


    var button2 = document.createElement('span');
    button2.style.width = '50px';
    button2.style.textAlign = 'center';
    var linkText = document.createTextNode("英文");
    button2.appendChild(linkText);
    button2.addEventListener('click', function(){ translate(1) });
    arr[0].appendChild(button2);

}

export default function initChinese(){

    var existCondition = setInterval(function() {

        var arr = document.getElementsByClassName("help-container");
    
        if (arr.length) {
           
            // 使用方式1: 初始化中文翻译按钮， 使用时手动点击
           console.log("add chinese button");
           clearInterval(existCondition);
           addButton();
    
           // 使用方式2: 持续自动翻译
           // console.log("translate");
           // translate();
    
        }
    }, 100);
    
}


   