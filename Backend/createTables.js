import fs from 'fs';

export default async function(bd) {
  let filesInOrder = ['drops', 'tables', 'inserts', 'procedures'];
  for (let file of filesInOrder) {
    let sqlFile = fs.readFileSync('./sql/' + file + '.sql', 'utf-8');
    if (file === 'drops') {
      // Modify the "drops.sql" file to contain DROP TABLE statements
      // for each table you want to force drop
      sqlFile = `
        DROP TABLE IF EXISTS Messages;

        DROP TABLE IF EXISTS TGroupsMembers;
        
        DROP TABLE IF EXISTS TGroups;
        
        DROP TABLE IF EXISTS Alarm;
      
        DROP TABLE IF EXISTS Product;
        
        DROP TABLE IF EXISTS Payment;
        
        DROP TABLE IF EXISTS Insurance;
        
        DROP TABLE IF EXISTS Supplier;

        DROP TABLE IF EXISTS Inventory;

        DROP TABLE IF EXISTS Orders;
        
        DROP TABLE IF EXISTS UAuthentication;
        
        DROP TABLE IF EXISTS Users;
      `;
    }
    await bd.query(sqlFile);
  }
}
