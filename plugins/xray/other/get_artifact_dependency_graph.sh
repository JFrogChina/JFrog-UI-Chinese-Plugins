
# xray api, -ukyle:apikey
curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/dependencyGraph/artifact" \
-H "Content-Type: application/json" \
--data-raw '{
    "path": "artifactory/libs-stage-local/org/jfrog/test/multi3/4.7/multi3-4.7.war"
}'


# "path": "artifactory/xray-maven-central-remote-cache/com/alibaba/fastjson/1.2.24/fastjson-1.2.24.jar" -> components = 自身.jar

# "path": "artifactory/libs-stage-local/org/jfrog/test/multi3/4.7/multi3-4.7.war" 
# components = parent pom 声明的依赖 + 自身直接声明的依赖 + multi1 的依赖 e.g. spring-aop 2.5.6 以及以下的依赖 - https://mvnrepository.com/artifact/org.springframework/spring-aop/2.5.6
# components 和 build info 收集到的依赖是一致的

# 物理上，multi3-4.7.war 包内包含各个组件，multi1-4.7.jar 内则只有 class，但 multi1 的 build info 是有依赖列表的

# e.g. 当前 block 9分以上
# A = 9分, A 底层依赖 B , B = 10分？
# 猜测 cvss 评分规则不会出现底层依赖比上层依赖分高的情况
# 此时只要申请 A 的白名单即可
# https://mvnrepository.com/artifact/org.springframework/spring-webmvc/4.3.22.RELEASE -> Compile Dependencies


# e.g. 当前 block 8分以上
# A = 10分, A 底层依赖 B , B = 9分
# 此时只要申请 A 的白名单即可，由管理员查看 B 是否被拒绝过，以此来决定是否通过 A 的申请

