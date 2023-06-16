

nohup jf rt u --threads 3 "./vuln_0/*" public-generic-dev-local/xraydb/ --recursive=true --flat=false > upload.log &
nohup jf rt u --threads 10 "./comp_0/*" public-generic-dev-local/xraydb/ --recursive=true --flat=false > upload.log &

