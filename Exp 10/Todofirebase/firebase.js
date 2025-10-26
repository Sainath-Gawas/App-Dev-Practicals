// database.js
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { collection, getDocs } from "firebase/firestore";

// Paste your Firebase Web App config here
const firebaseConfig = {
  apiKey: "AIzaSyC4NztD7GfU__dq3k06lWoZ5Tc7rySmKeg",
  authDomain: "todolist-firebase-293e7.firebaseapp.com",
  projectId: "todolist-firebase-293e7",
  storageBucket: "todolist-firebase-293e7.firebasestorage.app",
  messagingSenderId: "238035987275",
  appId: "1:238035987275:web:89183ffdab681ae57216ce",
  measurementId: "G-ZFJ24G7K30"
};

// Initialize Firebase app
const app = initializeApp(firebaseConfig);

// Initialize Firestore database
const db = getFirestore(app);

// Export db so other files can use it
export { db };
async function testFirestore() {
  const querySnapshot = await getDocs(collection(db, "tasks"));
  querySnapshot.forEach(doc => {
    console.log(doc.id, doc.data());
  });
}

testFirestore();