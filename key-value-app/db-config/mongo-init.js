const KeyValueDB = process.env.KEY_VALUE_DB;
const KeyValueUser = process.env.KEY_VALUE_USER;
const KeyValuePassword = process.env.KEY_VALUE_PASSWORD;

db = db.getSiblingDB(KeyValueDB)

db.createUser(
    {
  user: KeyValueUser,
  pwd: KeyValuePassword,
    roles: [
      {
        role: "readWrite",
        db: KeyValueDB
      }
    ]
    }
);

