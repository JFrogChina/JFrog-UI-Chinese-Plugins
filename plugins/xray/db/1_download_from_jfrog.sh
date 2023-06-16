

# source code
# https://github.com/jfrog/jfrog-cli-core/blob/master/xray/commands/offlineupdate/offlineupdate.go

# date range
# jf xr offline-update --license-id=xxx--version=3.47.3 --from=2022-08-01 --to=2022-08-03

nohup jf xr offline-update --license-id=$LICENSE_ID --version=3.47.3 > out.log &

# ./vuln_0.zip = 80M
# ./comp_0.zip = 18GB

