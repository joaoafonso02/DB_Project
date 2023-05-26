import express from 'express';
import sql from 'mssql'

const config = {
    server: 'localhost',
    port: 1433,
    user: 'SA',
    password: '<batata@BD>',
    database: 'TrotiNet',
    options: {
        trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
    },
};

// Create an instance of Express
const app = express();

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.get('/get_dbs', async (req, res) => {
    res.send(await app.locals.db.query('select name from sys.databases;'));
});

// INFO: example of a simple bd query
// app.get('/get_users', async (req, res) => {
//     res.send(await app.locals.db.query('select * from Users;'));
// });

// Start Express and then Start SQL
const port = 5000;
app.listen(port, async () => {
    app.locals.db = await sql.connect(config);
    (await import('./createTables.js')).default(app.locals.db);
    console.log(`Server is running on port ${port}`);
});


