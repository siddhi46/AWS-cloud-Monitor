const express = require('express');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const app = express();
const port = process.env.PORT || 3000;

// Configure AWS SDK
AWS.config.update({ region: 'us-east-1' });
const s3 = new AWS.S3();
const bucketName = 'your-s3-bucket-name';

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

app.post('/submit', (req, res) => {
  const userData = {
    name: req.body.name,
    email: req.body.email,
    timestamp: new Date().toISOString()
  };

  // Upload user data to S3
  const params = {
    Bucket: bucketName,
    Key: `user-data/${userData.timestamp}.json`,
    Body: JSON.stringify(userData),
    ContentType: 'application/json'
  };

  s3.upload(params, (err, data) => {
    if (err) {
      console.error('Error uploading data:', err);
      res.status(500).send('Error saving data.');
    } else {
      res.send(`<h1>Thank you, ${userData.name}!</h1><p>Your data has been saved.</p>`);
    }
  });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
