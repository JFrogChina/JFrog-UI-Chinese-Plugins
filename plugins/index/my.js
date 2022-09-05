new Vue({
    el: '#app',
    data: function() {
      return {           
        list: [
                  { 
                    name: 'native UI API demo',
                    url: '../native-ui-api/index.html',
                    desc: 'desc',
                    logo:  './images/jfrog.png'
                  },
                  { 
                    name: 'JFrog REST API demo',
                    url: '../rest-api/index.html',
                    desc: 'desc',
                    logo:  './images/jfrog.png'
                  },
                  { 
                    name: 'cleanup',
                    url: '../cleanup/index.html',
                    desc: 'desc',
                    logo:  './images/cleanup.png'
                  },
                  { 
                    name: 'xxx',
                    url: '../xxx/index.html',
                    desc: 'desc',
                    logo:  './images/default.png'
                  },
                  { 
                    name: 'xxx',
                    url: '../xxx/index.html',
                    desc: 'desc',
                    logo:  './images/default.png'
                  },
                  { 
                    name: 'xxx',
                    url: '../xxx/index.html',
                    desc: 'desc',
                    logo:  './images/default.png'
                  },
                  { 
                    name: 'xxx',
                    url: '../xxx/index.html',
                    desc: 'desc',
                    logo:  './images/default.png'
                  },
                  { 
                    name: 'xxx',
                    url: '../xxx/index.html',
                    desc: 'desc',
                    logo:  './images/default.png'
                  },
              ]
      }
    },
    created() {
      
    },
    methods: {
      fnOpen: function(url){
        window.open(url);
      }
    }
  })