new Vue({
    el: '#app',
    data: function() {
      return {           
        result : ''
      }
    },
    created() {
      this.fnBar();
    },
    methods: {


      // call REST API
      fnBar: function() {
        console.log('call REST API')
        let that = this;

        let baseUrl = window.location.protocol + '//' + window.location.host;
        baseUrl = baseUrl + '/artifactory/api/storage/example-repo-local';

        $.ajax({
            headers: {
              "Authorization": "Basic " + btoa(that.fnGetCookie('user') + ":" + that.fnGetCookie('token'))
            },  
            type: "GET",
            url: baseUrl,
            contentType: "application/json",
            success: function (data) {
                console.log('data=', data);
                that.result = JSON.stringify(data);
            }
        });
        
      },

      fnGetCookie : function(cname) {
          let name = cname + "=";
          let decodedCookie = decodeURIComponent(document.cookie);
          let ca = decodedCookie.split(';');
          for(let i = 0; i <ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
              c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
              return c.substring(name.length, c.length);
            }
          }
          return "";
      }

    }
  })