const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const port = 3000;

app.use(bodyParser.json());

app.post('/console', (req, res) => {
    console.log('Received POST request with JSON payload:', req.body);
    res.send('Data received and logged on the server.');
});

app.post('/file', (req, res) => {
    const data = JSON.stringify(req.body, null, 2);
    fs.appendFile('./output.json', data, (err) => {
        if (err) {
            console.error('Error writing to file:', err);
            res.status(500).send('Error writing to file.');
        } else {
            console.log('Data written to file:', data);
            res.send('Data written to file.');
        }
    });
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
