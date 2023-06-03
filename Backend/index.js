import express from 'express';
import sql from 'mssql';
import cors from 'cors';
import hat from 'hat';

// let config = {
//     server: 'localhost',
//     port: 1433,
//     user: 'SA',
//     password: '<batata@BD>',
//     database: 'TrotiNet',
//     options: {
//         trustServerCertificate: true, // Change to 'false' if not using a trusted certificate
//     },
// };

let config = {
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
let app = express();
app.use(express.json());
app.use(cors());

// Define routes
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

// app.get('/get_dbs', async (req, res) => {
//     res.send(await app.locals.db.query('select name from sys.databases;'));
// });

async function executeTrigger() {
    try {
      let pool = await sql.connect(config);
      await pool.request().execute('HashPassword');
      console.log('Trigger executed successfully.');
    } catch (error) {
      console.error('Error executing trigger:', error);
    } finally {
      sql.close();
    }
}

/* USER AUTHENTICATION */
app.post('/post_login', async (req, res) => {
    const { username, password } = req.body;

    let query1 = await app.locals.db.query(
      `SELECT id, upass FROM UAuthentication WHERE username = '${username}'`
    );
    if (query1.recordset.length !== 1) {
      res.send({ status: 'error', message: 'Wrong username or password.' });
      return;
    }
  
    let user = query1.recordset[0];
    let hashedPassword = user.upass;
    if (password !== hashedPassword) {
      res.send({ status: 'error', message: 'Wrong username or password.' });
      return;
    }
  
    let token = hat();
    let query2 = await app.locals.db.query( // useless
      `UPDATE UAuthentication SET utoken = '${token}' WHERE id = ${user.id}`
    );
  
    res.send({ status: 'ok', token });
  });

app.post('/post_register', async (req, res) => {
    let { username, email, password } = req.body;
    try {
        // Check if the username or email already exist
        let checkQuery = `SELECT UAuthentication.id FROM UAuthentication INNER JOIN Users ON UAuthentication.id = Users.id WHERE username = '${username}' OR email = '${email}';`;
        let checkResult = await app.locals.db.query(checkQuery);
        if (checkResult.recordset.length > 0) {
            res.send({ status: 'error', message: 'Username or email already exists.' });
            return;
        }

        let insertUserQuery = `INSERT INTO Users (email) VALUES ('${email}'); SELECT SCOPE_IDENTITY() AS userId;`;
        let insertUserResult = await app.locals.db.query(insertUserQuery);
        let userId = insertUserResult.recordset[0].userId;

        let token = hat();
        let insertAuthQuery = `INSERT INTO UAuthentication (id, username, upass, utoken) VALUES (${userId}, '${username}', '${password}', '${token}');`;
        await app.locals.db.query(insertAuthQuery);

        res.send({ status: 'ok', token });
    } catch (error) {
        console.error('Error registering user:', error);
        res.send({ status: 'error', message: 'Failed to register user.' });
    }
});


  

/* USER PROFILE */
app.post('/post_profile', async (req,res)=>{
    let {username,utoken} = req.body;
    let query2 = await app.locals.db.query(`select username, name, phone, email, postalZip,region, country from Users INNER JOIN UAuthentication ON Users.id=UAuthentication.id where UAuthentication.username='${username}' and UAuthentication.utoken='${utoken}'`)
    console.log(query2)
    res.send(query2.recordset[0])
})
app.post('/post_profile_edit', async (req,res) => {
    let {username,utoken,name,phone,email,postalZip,region,country} = req.body;
    let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}' and utoken='${utoken}';`)
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`update Users set name='${name}', phone='${phone}', email='${email}', postalZip='${postalZip}', region='${region}', country='${country}'`);
})
app.post('/post_profile_delete', async (req,res) => {
    let {username,utoken} = req.body;
    let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}' and utoken='${utoken}';`)
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`delete from UAuthentication where id=${id}`)
    let query3 = await app.locals.db.query(`delete from Users where id=${id}`)
    res.send({status:'ok'})
})

/* CHAT ROUTES */
app.post('/post_my_chats', async (req,res)=>{
    let {username,utoken} = req.body;
    console.log(username,utoken)
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
    let {group_id} = req.body;
    let query1 = await app.locals.db.query(`select * from Messages INNER JOIN UAuthentication ON Messages.user_id=UAuthentication.id where group_id=${group_id}`);
    // console.log(query1.recordset)
    res.send(query1.recordset);
})
app.post('/post_send_message', async (req,res)=>{
    // TODO: verify if user can read this messages
    let {username,utoken,msg_text,group_id} = req.body;
    let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}';`);
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`insert into Messages (msg_text,group_id,user_id) values ('${msg_text}',${group_id},${id})`);
    res.send({})
})

app.post('/post_new_chat', async (req, res) => {
    let { username, utoken, title, usernames } = req.body;
    
    // Insert into TGroups and retrieve the group_id
    let insertQuery = `INSERT INTO TGroups (group_name) VALUES ('${title}'); SELECT SCOPE_IDENTITY() AS id;`;
    let result = await app.locals.db.query(insertQuery);
    
    if (result.recordset && result.recordset.length > 0) {
      let groupId = result.recordset[0].id;
    
      // Insert into TGroupsMembers for each username
      for (let e of usernames) {
        let userQuery = `SELECT id FROM UAuthentication WHERE username = '${e}'`;
        let userResult = await app.locals.db.query(userQuery);
        
        if (userResult.recordset && userResult.recordset.length > 0) {
          let userId = userResult.recordset[0].id;
          
          let groupMemberQuery = `INSERT INTO TGroupsMembers (group_id, user_id) VALUES (${groupId}, ${userId})`;
          await app.locals.db.query(groupMemberQuery);
        }
      }
    
      res.send({ status: "ok" });
    } else {
      res.send({ status: "error", message: "Failed to create group." });
    }
  });
  
  

app.post('/post_delete_chat', async (req,res)=>{
    let {username,utoken,group_id} = req.body;
    let query1 = await app.locals.db.query(`delete from TGroups where group_id=${group_id};`);
    res.send({status:"ok"})
})

app.post('/post_filter_chats_sql', async (req, res) => {
    let { username, utoken, searchInput } = req.body;
  
    try {
      let request = new sql.Request(app.locals.db);
      request.input('username', sql.NVarChar, username);
      request.input('searchInput', sql.NVarChar, searchInput);
  
      let result = await request.execute('FilterChats');
      let filteredChats = result.recordset;
      res.send(filteredChats);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  });
  
  
  

app.post('/post_usernames', async (req, res) => {
    try {
      let query1 = await app.locals.db.query('GetUsers'); // Execute the stored procedure
      let usernames = query1.recordset.map(record => record.name); // Extract the usernames from the result
      res.send(usernames);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
});

// Start Express and then Start SQL
let port = 5004;
app.listen(port, async () => {
    app.locals.db = await sql.connect(config);
    (await import('./createTables.js')).default(app.locals.db);
    // execute HashPassword trigger
    console.log(`Server is running on port ${port}`);
});
