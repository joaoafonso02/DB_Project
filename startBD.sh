sudo docker run \
    -e "ACCEPT_EULA=Y" \
    -e "MSSQL_SA_PASSWORD=<batata@DB>" \
    -p 1433:1433 \
    --name sql1 \
    --hostname sql1 \
    -d mcr.microsoft.com/mssql/server:2022-latest;

sudo docker exec -it sql1 "bash"

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<batata@DB>"