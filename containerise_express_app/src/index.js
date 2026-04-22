const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = process.env.PORT;
const users = [];

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});
app.get('/users', (req, res) => {
    res.json(users);
});
app.post('/users', (req, res) => {
    const newUserID =  req.body.userId;
    if (!newUserID) {
        return res.status(400).json({ error: 'userId is required' });
    }
    if (users.includes(newUserID)) {
        return res.status(400).json({ error: 'User already exists' });
    }
    users.push(newUserID);
    res.status(201).json({ message: 'User added successfully', userId: newUserID });
});

app.listen(port, () => {
  console.log(`Express app listening at ${port}`);
});