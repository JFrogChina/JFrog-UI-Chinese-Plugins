new Vue({
    el: '#app',
    data: function() {
      return {           
        aql: '',
        tableData: [],
        multipleSelection: []
      }
    },
    created() {
      
      
    },
    methods: {

      fnAQL: function(){
        let that = this;
      
        // search by aql
        let baseUrl = window.location.protocol + '//' + window.location.host;
        baseUrl = baseUrl + '/artifactory/api/search/aql';
        
        let payload = that.aql;
        $.ajax({
            headers: {
              "Authorization": "Basic " + btoa(that.fnGetCookie('user') + ":" + that.fnGetCookie('token'))
            },    
            type: "POST",
            url: baseUrl,
            data: payload,
            contentType: "text/plain",
            dataType:'json',
            success: function (data) {
              
              data.results.forEach(e=>{
                 e.size = (e.size / (1024*1024)).toFixed(3);
                 e.status = '';
              })
              that.tableData = data.results;
              
              that.$message({
                  showClose: true,
                  message: 'Success',
                  type: 'success'
                });
                
            }, error:function(data){
              that.$message({
                showClose: true,
                message: data.messages[0].message,
                type: 'error'
              });
            }
        });

      },

      fnDelete: function(){
        let that = this;

        that.multipleSelection.forEach(e=>{
          let baseUrl = window.location.protocol + '//' + window.location.host;
          baseUrl = baseUrl + '/artifactory/' + e.repo;
          if(e.path != '.'){
            baseUrl = baseUrl + '/' + e.path;
          }
          baseUrl = baseUrl + '/' + e.name;

          $.ajax({
              username: that.fnGetCookie('user'),
              password: that.fnGetCookie('token'),
              type: "DELETE",
              url: baseUrl,
              contentType: "application/json",
              success: function (data) {
                e.status = 'deleted'
              }, error:function(data){
                e.status = 'failed to delete'
            }
          });
            e.status = '';
        })

        
      },

      handleSelectionChange(val) {
        this.multipleSelection = val;
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