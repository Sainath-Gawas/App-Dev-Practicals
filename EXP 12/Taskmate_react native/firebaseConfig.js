import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyAi_TCKUk7-sMNGZkLOkGEg7m-9gAuwd7w",
  authDomain: "taskmate-78a49.firebaseapp.com",
  projectId: "taskmate-78a49",
  storageBucket: "taskmate-78a49.appspot.com",
  messagingSenderId: "499175054165",
  appId: "1:499175054165:web:30e17ff18fa81a1a5ceddc",
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);
