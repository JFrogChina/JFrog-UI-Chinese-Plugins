
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
            baseUrl = baseUrl + '/artifactory/api/security/encryptedPassword';

            let headers = new Headers();
            headers.append('Authorization', 'Basic ' + btoa(json.user + ":" + json.password));

            const data = await fetch(baseUrl, {method:'GET', headers: headers}).then(res => res.text());
            console.log('encrypted password=', data);

            // 3. for later usage in ajax header
            document.cookie = "user="+ json.user +"; max-age=3600; path=/;";
            document.cookie = "password="+ data +"; max-age=3600; path=/;";
        }
    }  
    nativeSend.apply(this, arguments);
};
XMLHttpRequest.prototype.send = proxiedSend;



  