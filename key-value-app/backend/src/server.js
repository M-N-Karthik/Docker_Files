const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const { healthRouter } = require('./routes/health');
const { keyValueRouter } = require('./routes/store');

const app = express();

app.use(bodyParser.json());
app.use('/health', healthRouter);
app.use('/store', keyValueRouter);

const PORT = process.env.PORT;  

console.log('Connecting to MongoDB...');
mongoose.connect(`mongodb://${process.env.MONGO_DBHOST}/${process.env.KEY_VALUE_DB}`, {
    auth: {
        username: `${process.env.KEY_VALUE_USER}`,
        password: `${process.env.KEY_VALUE_PASSWORD}`
    },
    connectTimeoutMS: 5000
})
.then(() => {
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}`);
    });
    console.log('Connected to MongoDB');
})
.catch(err => {
    console.error('Failed to connect to MongoDB', err);
    process.exit(1);
});