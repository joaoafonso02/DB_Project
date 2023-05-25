const express = require('express');
const sql = require('mssql');

const config = {
    server: 'localhost',
    port: 1433,
    user: 'SA',
    password: '<batata@BD>',
    database: 'testdb',
    options: {
        trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
    },
};

// Create an instance of Express
const app = express();

(async () => {
    try {
        // make sure that any items are correctly URL encoded in the connection string
        await sql.connect(config)
        const result = await sql.query`select name from sys.databases`
        console.dir(result)
    } catch (err) {
        console.log("bla",err)
    }
})();

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.get('/get_dbs', async (req, res) => {
    await sql.connect(config)
    const result = await sql.query(`select name from sys.databases`)
    res.send(result.recordset)
});



// Start the server
const port = 5000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});


