
import * as i18n from './i18n/i18n.js'; 

// prepare auth for jfrog rest api
// 1. get username/password
const nativeSend = XMLHttpRequest.prototype.send;
const proxiedSend = async function (body) {
    if(body){
        
        let json = undefined;
        try {
            json = JSON.parse(body);
        } catch (error) {
            console.log('not json body, no worry', error);
        }
        
        if(json && json.user && json.password) {
            console.log('login action');

            // 2. call api to get access token
            let baseUrl = window.location.protocol + '//' + window.location.host;
            baseUrl = baseUrl + '/artifactory/api/security/token';

            let headers = new Headers();
            headers.append('Authorization', 'Basic ' + btoa(json.user + ":" + json.password));
            headers.append('Content-Type', 'application/x-www-form-urlencoded');

            var details = {
                'username': json.user,
                'scope': 'member-of-groups:*'
            };
            
            var formBody = [];
            for (var property in details) {
            var encodedKey = encodeURIComponent(property);
            var encodedValue = encodeURIComponent(details[property]);
            formBody.push(encodedKey + "=" + encodedValue);
            }
            formBody = formBody.join("&");
            
            const data = await fetch(baseUrl, {method:'POST', headers: headers, body: formBody}).then(res => res.json());
            let token = data.access_token;
            console.log('token ready');

            // 3. for later usage in ajax header
            document.cookie = "user="+ json.user +"; max-age=3600; path=/;";
            document.cookie = "token="+ token +"; max-age=3600; path=/;";
        }
        
    }  
    nativeSend.apply(this, arguments);
};
XMLHttpRequest.prototype.send = proxiedSend;

// some functions
function addButton(className, text, func){

    let arr = document.getElementsByClassName(className);
    if(arr.length){
        let button = document.createElement('span');
        button.style.width = '50px';
        button.style.textAlign = 'center';
        let linkText = document.createTextNode(text);
        button.appendChild(linkText);
        button.addEventListener('click', func);
        arr[0].appendChild(button);
    }
    
}

// init plugins
function initPlugins(){

    let className = 'help-container';
    var existInitPlugins = setInterval(function() {

        let arr = document.getElementsByClassName(className);
        if (arr.length) {
            console.log("ready to add ui plugins");
                    
            // add i18n plugin
            // i18n.config.autoTranslate = true;
            // i18n.config.autoTarget = '中文';

            i18n.init(i18n.config)

            // add other UI plugins
            addButton(className, 'UI Plugins', function(){
                let baseUrl = window.location.protocol + '//' + window.location.host;
                baseUrl = baseUrl + '/ui/plugins/index/';
                window.open(baseUrl);
            });

            clearInterval(existInitPlugins);
        }
    }, 100);
    
}

initPlugins();


