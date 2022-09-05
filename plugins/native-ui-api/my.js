new Vue({
    el: '#app',
    data: function() {
      return {           
        tableData: []
      }
    },
    created() {
      this.fnFoo();
    },
    methods: {

      // call UI API
      fnFoo: function() {
        console.log('call UI API')
        let that = this;

        let data = {"projectKey":"","type":"root","mustInclude":null,"packageTypes":[],"repositoryTypes":[],"sortBy":"REPO_TYPE","continueState":null,"byRepoKey":null,"repositoryKeys":[]};

        let baseUrl = window.location.protocol + '//' + window.location.host;
        baseUrl = baseUrl + '/ui/api/v1/ui/treebrowser?compacted=true';

        $.ajax({
            type: "POST",
            url: baseUrl,
            data: JSON.stringify(data),
            contentType: "application/json",
            headers: {"X-Requested-With": "XMLHttpRequest"},
            success: function (data) {
                console.log('data=', data);
                that.tableData = data.data;
                that.$message({
                    showClose: true,
                    message: 'Success',
                    type: 'success'
                });
            }
        });
        
      },

    }
  })