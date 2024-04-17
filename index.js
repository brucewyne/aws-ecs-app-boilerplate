import express from 'express';

const app = express();

app.use('/', (request, response) => {
  return response.send('hi');
});

app.listen(3000, () => {
  console.log('App Starting')
});
