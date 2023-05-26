import fs from 'fs';

export default async function(bd) {
  let sqlFile = fs.readFileSync('../projectDB.sql', 'utf-8');
    await bd.query(sqlFile)
}
