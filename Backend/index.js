import express from 'express';
import sql from 'mssql';
import cors from 'cors';
import hat from 'hat';

// let configLocal = {
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

function comparePassword(password, hashedPassword) {
    return password === hashedPassword;
}

/* USER AUTHENTICATION */
app.post('/post_login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await app.locals.db.query(`EXEC CheckPasswordValidity @pass='${password}', @username='${username}';`);
    res.send({ status: 'ok', token:result.recordset[0].utoken });
  } catch (error) {
        console.error('Error logging in:', error);
        res.send({ status: 'error', message: 'Failed to log in.' });
  }
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
app.post('/post_profile', async (req, res) => {
    let { username, utoken } = req.body;
    let query = await app.locals.db.query(`SELECT username, name, phone, email, postalZip, region, country FROM Profile WHERE username='${username}' AND utoken='${utoken}'`);
    console.log(query);
    res.send(query.recordset[0]);
  });
  
app.post('/post_profile_edit', async (req, res) => {
    let { username, utoken, name, phone, email, postalZip, region, country } = req.body;
    let query1 = await app.locals.db.query(`SELECT id FROM Profile WHERE username='${username}' AND utoken='${utoken}'`);
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`UPDATE Users SET name='${name}', phone='${phone}', email='${email}', postalZip='${postalZip}', region='${region}', country='${country}' WHERE id=${id}`);
});

app.post('/post_profile_delete', async (req, res) => {
    let { username, utoken } = req.body;
    let query1 = await app.locals.db.query(`SELECT id FROM Profile WHERE username='${username}' AND utoken='${utoken}'`);
    let id = query1.recordset[0].id;
    let query2 = await app.locals.db.query(`DELETE FROM UAuthentication WHERE id=${id}`);
    let query3 = await app.locals.db.query(`DELETE FROM Users WHERE id=${id}`);
    res.send({ status: 'ok' });
});
  

/* CHAT ROUTES */
app.post('/post_my_chats', async (req,res)=>{
    let {username,utoken} = req.body;
    console.log(username,utoken)
    // let query1 = await app.locals.db.query(`select * from TGroupMembers;`)
    let query1 = await app.locals.db.query(`
        select Tgroups.gname,Tgroups.id 
        from (TGroups INNER JOIN TGroupMembers 
            ON Tgroups.id=TGroupMembers.group_id
            ) 
            INNER JOIN UAuthentication 
            on TGroupMembers.user_id=UAuthentication.id 
            where UAuthentication.username='${username}'`);
    let ret = [];
    for( let chat of query1.recordset ) {
        if( chat.gname=="" ) {
            let query2 = await app.locals.db.query(`select UAuthentication.id,UAuthentication.username from UAuthentication INNER JOIN TGroupMembers ON UAuthentication.id=TGroupMembers.user_id where TGroupMembers.group_id=${chat.id};`);
            console.log(query2)
            chat.gname = query2.recordset.find(e=>e.username!=username).username
        }
        ret.push({ ...chat });
    }
    console.log(ret)
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
    let {username,utoken,msg,group_id} = req.body;
    try {
        let query1 = await app.locals.db.query(`select id from UAuthentication where username='${username}';`);
        let id = query1.recordset[0].id;
        let query2 = await app.locals.db.query(`insert into Messages (msg,group_id,user_id) values ('${msg}',${group_id},${id})`);
        res.send({})
    } catch (error) {
        console.error('Error registering user:', error);
        res.send({ status: 'error', message: 'Failed to register user.' });
    }
})

app.post('/post_new_chat', async (req, res) => {
    let { username, utoken, title, usernames } = req.body;

    try {
        let query = await app.locals.db.query(`EXEC CreateChat @cname='${title}', @arrayUsernames='${usernames}'`);
        res.send({})
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
    
    // Insert into TGroups and retrieve the group_id
    // let insertQuery = `INSERT INTO TGroups (group_name) VALUES ('${title}'); SELECT SCOPE_IDENTITY() AS id;`;
    // let result = await app.locals.db.query(insertQuery);
    
    // if (result.recordset && result.recordset.length > 0) {
    //     let groupId = result.recordset[0].id;
        
    //     // Insert into TGroupsMembers for each username
    //     for (let e of usernames) {
    //         let userQuery = `SELECT id FROM UAuthentication WHERE username = '${e}'`;
    //         let userResult = await app.locals.db.query(userQuery);
            
    //         if (userResult.recordset && userResult.recordset.length > 0) {
    //             let userId = userResult.recordset[0].id;
                
    //             let groupMemberQuery = `INSERT INTO TGroupsMembers (group_id, user_id) VALUES (${groupId}, ${userId})`;
    //             await app.locals.db.query(groupMemberQuery);
    //         }
    //     }
    
    //     res.send({ status: "ok" });
    // } else {
    //     res.send({ status: "error", message: "Failed to create group." });
    // }
  });
  
  

app.post('/post_delete_chat', async (req,res)=>{
    let {username,utoken,group_id} = req.body;
    console.log(group_id)
    try {
        let query1 = await app.locals.db.query(`delete from TGroups where id=${group_id};`);
        res.send({status:"ok"})
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
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

// get trotis attributes
app.post('/post_trotis', async (req, res) => {
    try {
        const { trotiId, trotiBattery, insurance_id, alarm_id, availability_status, trotiLat, trotiLng } = req.body;
  
        console.log(`Troti attributes received successfully! Battery: Id=${trotiId},  ${trotiBattery}%, Insurance: ${insurance_id}, Alarm: ${alarm_id}, Availability: ${availability_status}, Location: ${trotiLat}, ${trotiLng}`);

        const insertQuery = `INSERT INTO Product (battery, insurance_id, alarm_id, availability_status, trotiLat, trotiLong) 
                            VALUES (${trotiBattery}, ${insurance_id}, ${alarm_id}, '${availability_status}', ${trotiLat}, ${trotiLng})`;
        await app.locals.db.query(insertQuery);

        res.send({ status: "ok" }); // Send a response indicating successful insertion

    } catch (error) {
        // Handle any errors that occurred during processing
        console.error('Error receiving Troti attributes:', error);
        res.status(500).json({ error: 'An error occurred while receiving Troti attributes' });
    }
});

async function getTrotis() {
    try {
      const query = "SELECT * FROM Product";
      const result = await app.locals.db.query(query);
      return result.recordset;
    } catch (error) {
      console.error("Error retrieving trotis:", error);
      throw error;
    }
}
  
  // Define a route to handle the frontend's request for trotis
app.get("/get_trotis", async (req, res) => {
    try {
      const trotis = await getTrotis();
      console.log("Trotis retrieved successfully!");
      res.send(trotis);
    } catch (error) {
      console.error("Error handling troti request:", error);
      res.status(500).send("Internal Server Error");
    }
}); 

// confirm destination and update troti status
app.post('/confirm_destination', async (req, res) => {
    try {
      const { user_id, payment, product } = req.body;
  
      console.log(`Confirmation received successfully! User: ${user_id}, Payment: ${payment}, Product: ${product}`);
  
      if (user_id === undefined || payment === undefined || product === undefined) {
        throw new Error('Invalid request body');
      }
  
      const paymentInt = parseInt(payment, 10); // Convert payment string to an integer
  
      // Check if the payment exists in the Payment table
    //   const paymentCheckQuery = `SELECT COUNT(*) AS count FROM Payment WHERE id = ${paymentInt}`;
    //   const paymentCheckResult = await app.locals.db.query(paymentCheckQuery);
  
    //   if (paymentCheckResult.recordset[0].count === 0) {
    //     throw new Error('Invalid payment');
    //   }
  
      // Insert values into the Orders table using parameterized queries
      const query = `INSERT INTO Orders (user_id, payment, product) VALUES ( ${user_id},  ${paymentInt},  ${product})`;
      await app.locals.db.query(query, { user_id, payment: paymentInt, product });
  
      res.json({ success: true });
    } catch (error) {
      console.error('Error inserting confirmation:', error);
      res.status(500).json({ error: 'Internal Server Error' });
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
    console.log(`Server is running on port ${port}`);
});
