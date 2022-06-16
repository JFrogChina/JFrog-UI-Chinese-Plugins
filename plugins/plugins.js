
// chinese plugin
import initChinese from './chinese/chinese.js'; 
initChinese();

// auth for jfrog rest api
// 1. get username/password
const nativeSend = XMLHttpRequest.prototype.send;
const proxiedSend = async function (body) {
    if(body){
        let json = JSON.parse(body);
        if(json.user && json.password) {
            console.log('login action');

            // 2. call profile api to get encrypted password
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
            console.log('token=', token);

            // 3. for later usage in ajax header
            document.cookie = "user="+ json.user +"; max-age=3600; path=/;";
            document.cookie = "token="+ token +"; max-age=3600; path=/;";
        }
    }  
    nativeSend.apply(this, arguments);
};
XMLHttpRequest.prototype.send = proxiedSend;



  