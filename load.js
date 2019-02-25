const admin = require('./node_modules/firebase-admin');
const serviceAccount = require("./service-key.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),  
  databaseURL: "https://YOUR_DB.firebaseio.com"
});