
# open browser
# https://demo.jfrogchina.com/artifactory/app1-maven-snapshot-local/org/jfrog/test/multi3/4.7-SNAPSHOT/multi3-4.7-SNAPSHOT.war
# header = X-Artifactory-Filename: multi3-4.7.war

URL=https://demo.jfrogchina.com/artifactory/app1-maven-snapshot-local/org/jfrog/test/multi3/4.7-SNAPSHOT/multi3-4.7-SNAPSHOT.war

FILENAME=$(curl -X GET $URL -I -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' | grep X-Artifactory-Filename | sed 's/X-Artifactory-Filename: //g')
curl -X GET $URL  -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' -o $FILENAME
