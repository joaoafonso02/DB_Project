import fs from 'fs';

export default async function(bd) {
  let filesInOrder = ['drops2', 'tables2', 'triggers'];
  for (let file of filesInOrder) {
    let sqlFile = fs.readFileSync('./sql/' + file + '.sql', 'utf-8');
    await bd.query(sqlFile);
  }
}
