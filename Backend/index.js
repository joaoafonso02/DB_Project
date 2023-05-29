import express from 'express';
import sql from 'mssql';
import cors from 'cors';
import hat from 'hat';
import { createServer } from 'http';
import { Server } from 'socket.io';

// const config = {
//     server: 'localhost',
//     port: 1433,
//     user: 'SA',
//     password: '<batata@BD>',
//     database: 'TrotiNet',
//     options: {
//         trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
//     },
// };
const config = {
    server: 'mednat.ieeta.pt',
    port: 8101,
    user: 'p1g7',
    password: 'batata@BD',
    database: 'p1g7',
    options: {
        trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
    },
};

// Create an instance of Express
const app = express();
app.use(express.json());
app.use(cors());

// create websocket server
const app2 = express();
const server = createServer(app2);
const io = new Server(server);
app2.use(cors())

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

// app.get('/get_dbs', async (req, res) => {
//     res.send(await app.locals.db.query('select name from sys.databases;'));
// });

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

/* CHAT ROUTES */
app.post('/post_my_chats', async (req,res)=>{
    const {username,utoken} = req.body;
    let query1 = await app.locals.db.query(`select Tgroups.group_name,Tgroups.group_id from (TGroups INNER JOIN TGroupsMembers ON Tgroups.group_id=TGroupsMembers.group_id) INNER JOIN UAuthentication on TGroupsMembers.user_id=UAuthentication.id where UAuthentication.username='${username}'`);
    let ret = [];
    for( let chat of query1.recordset ) {
        if( chat.group_name=="" ) {
            let query2 = await app.locals.db.query(`select UAuthentication.id,UAuthentication.username from UAuthentication INNER JOIN TGroupsMembers ON UAuthentication.id=TGroupsMembers.user_id where TGroupsMembers.group_id=${chat.group_id};`);
            chat.group_name = query2.recordset.find(e=>e.username!=username).username
        }
        ret.push( {...chat} )
    }
    res.send(ret)
})
app.post('/post_my_messages', async (req,res)=>{
    // TODO: verify if user can read this messages
    const {group_id} = req.body;
    let query1 = await app.locals.db.query(`select * from Messages INNER JOIN UAuthentication ON Messages.user_id=UAuthentication.id where group_id=${group_id}`);
    // console.log(query1.recordset)
    res.send(query1.recordset);
})
app.post('/post_send_message', async (req,res)=>{
    // TODO: verify if user can read this messages
    const {username,utoken,msg_text,group_id} = req.body;
    let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}';`);
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`insert into Messages (msg_text,group_id,user_id) values ('${msg_text}',${group_id},${id})`);
    res.send({})
})
app.post('/post_new_chat', async (req,res)=>{
    const {username,utoken,title,usernames} = req.body;
    let query1 = await app.locals.db.query(`INSERT INTO TGroups (group_name) VALUES ('${title}');select SCOPE_IDENTITY() as id;`);
    usernames.forEach(async e => {
        let query2 = await app.locals.db.query(`select id from UAuthentication where username='${e}'`)
        let query3 = await app.locals.db.query(`insert into TGroupsMembers (group_id, user_id) VALUES (${query1.recordset[0].id}, ${query2.recordset[0].id})`)
    });
    res.send({status:"ok"})
})
// Chat tcp connection
// io.on('connection', (socket) => {
//     console.log('A new client connected');
  
//     // Event listener for chat messages from clients
//     // socket.on('chat message', (msg) => {
//     //   console.log('Received message:', msg);
  
//     //   // Broadcast the message to all connected clients
//     // //   io.emit('chat message', msg);
//     // });
  
//     // Event listener for disconnection
//     socket.on('disconnect', () => {
//       console.log('A client disconnected');
//     });
//   });

// INFO: example of a simple bd query
// app.get('/get_users', async (req, res) => {
//     res.send(await app.locals.db.query('select * from Users;'));
// });







// Start Express and then Start SQL
const port = 5001;
app.listen(port, async () => {
    app.locals.db = await sql.connect(config);
    (await import('./createTables.js')).default(app.locals.db);
    console.log(`Server is running on port ${port}`);
});

// Start TCP Server
// server.listen(5001, ()=>{
//     console.log(`WebSocket server listening on port 5001`);
// })

