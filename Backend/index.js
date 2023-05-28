import express from 'express';
import sql from 'mssql';
import cors from 'cors';
import hat from 'hat';

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
// const config = {
//     server: 'mednat.ieeta.pt',
//     port: 8101,
//     user: 'p1g7',
//     password: 'batata@BD',
//     database: 'p1g7',
//     options: {
//         trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
//     },
// };

// Create an instance of Express
const app = express();
app.use(express.json());
app.use(cors());

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.get('/get_dbs', async (req, res) => {
    res.send(await app.locals.db.query('select name from sys.databases;'));
});

/* USER AUTHENTICATION */
app.post('/post_login', async (req,res)=>{
    const { username, password } = req.body;
    let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}' and upass='${password}'; `);
    if( query1.recordsets[0].length!=1 ) { res.send({status:'error', message:'Wrong username or password.'});return; }
    let token = hat();
    let query2 = await app.locals.db.query(`update UAuthentication set utoken='${token}' where id=${query1.recordsets[0][0].id}`);
    res.send({status:"ok",token});
});
app.post('/post_register', async (req,res)=>{
    const { username, email, password } = req.body;
    let query1 = await app.locals.db.query(`select Users.id from UAuthentication inner join Users on UAuthentication.id=Users.id where username='${username}' or email='${email}'; `);
    if( query1.recordsets[0].length!=0 ) { res.send({status:'error', message:'Username or email already exist.'});return; }
    let token = hat();
    let query2 = await app.locals.db.query(`
        BEGIN TRANSACTION;
        DECLARE @GeneratedID INT;
        INSERT INTO Users (email) VALUES ('${email}');
        SET @GeneratedID = SCOPE_IDENTITY();
        INSERT INTO UAuthentication (id, username, upass, utoken) VALUES (@GeneratedID, '${username}', '${password}', '${token}');
        COMMIT;
    `);
    res.send({status:"ok",token});
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


