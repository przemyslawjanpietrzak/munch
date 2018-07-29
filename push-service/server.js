const webPush = require('web-push');
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const fs = require('fs');

const app = express(bodyParser.json);

app.use(express.static(path.join(__dirname, 'client')));
app.use(bodyParser.json());

const publicKey = 'BG4X5DcVOgTS40-spPWLGBvdWz4pziCQwYs93YPFO0TK0fSXC5sBPSVV4Y5tDbLvDAdJmb8zIE77VsIXObPiuwk';
const privateKey = 'wM0npsGHnKOWKewgGxXa38egfsMyKb-S4QLWBPugSdk'; // shame shame shame

let subscriptions = [];

webPush.setVapidDetails(
  'mailto:pjpp92@gmail.com',
  publicKey,
  privateKey
);

app.post('/ps/subscribe', (req, res) => {
  const subscription = req.body;

  res.sendStatus(201, {});

  subscriptions.push(subscription);
})

const port = 3000;

app.listen(port, () => console.log(`start on ${port}`));

setInterval(() => {
  fs.readFile(path.join(__dirname, 'new-version.txt'), 'utf8', (err) => {
    if (!err) {
      subscriptions.forEach(sub => {
        const payload = JSON.stringify({ title: 'push test' });

        webPush
          .sendNotification(sub, payload)
          .catch(err => console.error(err));
      });
      fs.unlink('./new-version.txt', () => {});
    }
  });
}, 5000);
