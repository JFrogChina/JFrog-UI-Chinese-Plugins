
# show download threads 
export CI=true

jf c use art-mj-target

# remove existing
rm -rf /Users/kyle/Downloads/mj/2-download/*.nsp

# download new
# default min-split = 5120 KB
jf rt dl --threads 3 --split-count 3 --min-split 5120 --spec download_by_aql.json



