

# login pg via pdAdmin
# create role = apiuser
# create db = pipelinesdb, owner = apiuser, security = ALL

# login
psql -d pipelinesdb -U apiuser
psql -d pipelinesdb -U apiuser -h x.x.x.x -p 5432

# export/import (requires client/server version match)
pg_dump pipelinesdb > dumpfile -U apiuser -h x.x.x.x -p 5432

