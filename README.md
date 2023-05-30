
# launch the MSSQL docker
```
sudo docker run \
    -e "ACCEPT_EULA=Y" \
    -e "MSSQL_SA_PASSWORD=<batata@DB>" \
    -p 1433:1433 \
    --name sql1 \
    --hostname sql1 \
    -d mcr.microsoft.com/mssql/server:2022-latest;
```

## Create the db

access the container
```
sudo docker exec -it sql1 "bash"
```

connect to the SQL Server
```
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<batata@DB>"
```

query to create the db
```
create database TrotiNet;
GO
```

# Launch the Backend
```
cd Backend
npm install socket.io
sudo npm install
npm run dev
```

# Launch the Frontend
```
cd Frontend
sudo npm install
npm run dev
```