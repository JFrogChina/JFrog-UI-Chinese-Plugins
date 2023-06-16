


- document
https://www.jfrog.com/confluence/display/JFROG/VCS+Repositories

- list all branch
curl -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' -XGET https://demo.jfrogchina.com/artifactory/api/vcs/branches/vcs-github-remote/jquery/jquery

- download branch
curl -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' -XGET https://demo.jfrogchina.com/artifactory/api/vcs/downloadBranch/vcs-github-remote/jquery/jquery/main --output jquery.tar.gz

