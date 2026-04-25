const keyValueDB = process.env.KEY_VALUE_DB_NAME 
const keyValueUsername = process.env.KEY_VALUE_DB_USER 
const keyValuePassword = process.env.KEY_VALUE_DB_PASSWORD

console.log('Initializing MongoDB with the following credentials:');
db = db.getSiblingDB(keyValueDB);
db.createUser(
    {
        user: keyValueUsername,
        pwd: keyValuePassword,
        roles: [
            {
                role: "readWrite",
                db: keyValueDB
            }
        ]
    }
);