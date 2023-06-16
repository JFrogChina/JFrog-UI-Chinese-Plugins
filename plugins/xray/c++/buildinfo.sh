# Choose between A or B or C (depending where your dependencies are located) :
# # A. add Build info dependencies located on the local disk
# ##### jfrog rt bad myLibs/ cpp_build 1
# # B. add Build info dependencies located in Artifactory
# ##### jfrog rt bad mcy-cpp-deps/ --from-rt=true cpp_build 1
# # C. add Build info dependencies by downloading them from Artifactory
# #### jfrog rt dl mcy-cpp-deps/ cpp_build 1
 
# jfrog rt bad myLibs/ cpp_build 1
jf rt bad cpp_build 3 "myLibs/"


# generate Build info and save it as JSON file
jf rt bp --dry-run=true  cpp_build 3 > build_info.json
 
# the following command will :
# 1. add type=cpp to the module
# 2. add type=cpp for each dependency
# 3. update the component id for each dependency
jq '.modules[] += {"type":"cpp"}' build_info.json |\
jq '.modules[].dependencies[] += {"type":"cpp"}'  |\
jq '(.modules[].dependencies[] | select(.id == "Poco.dll" ) | .id)    |= "poco:1.8.0"' |\
jq '(.modules[].dependencies[] | select(.id == "libcurl.dll" ) | .id) |= "haxx:libcurl:7.70.0"' |\
jq '(.modules[].dependencies[] | select(.id == "sqlite.dll" ) | .id)  |= "sqlite:3.15.1"' |\
jq '(.modules[].dependencies[] | select(.id == "zlib.dll" ) | .id)    |= "zlib:1.2.0"' > build_info_xray.json
 
# upload build info
jf rt curl -XPUT /api/build -H "Content-Type: application/json" -T build_info_xray.json

