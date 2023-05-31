import fs from 'fs';

export default async function(bd) {
  let filesInOrder = ['drops', 'tables', 'inserts', 'procedures'];
  for (let file of filesInOrder) {
    let sqlFile = fs.readFileSync('./sql/' + file + '.sql', 'utf-8');
    await bd.query(sqlFile);
  }
}
