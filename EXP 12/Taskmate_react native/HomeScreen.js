import React, { useState, useEffect, useRef } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
  Keyboard,
} from "react-native";
import { signOut } from "firebase/auth";
import {
  collection,
  addDoc,
  onSnapshot,
  query,
  where,
  deleteDoc,
  doc,
  updateDoc,
} from "firebase/firestore";
import { auth, db } from "./firebaseConfig";

export default function HomeScreen({ user }) {
  const [task, setTask] = useState("");
  const [tasks, setTasks] = useState([]);
  const inputRef = useRef(null);

  // 🔹 Fetch tasks in real-time
  useEffect(() => {
    const q = query(collection(db, "tasks"), where("uid", "==", user.uid));
    const unsubscribe = onSnapshot(q, (snapshot) => {
      const tasksData = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      setTasks(tasksData.sort((a, b) => b.createdAt?.seconds - a.createdAt?.seconds));
    });
    return unsubscribe;
  }, []);

  // 🔹 Add a new task
  const handleAddTask = async () => {
  const trimmedTask = task.trim();
  if (trimmedTask === "") return;

  // ✅ Immediately clear input before async work
  setTask("");
  Keyboard.dismiss();

  try {
    await addDoc(collection(db, "tasks"), {
      text: trimmedTask,
      completed: false,
      uid: user.uid,
      createdAt: new Date(),
    });

    // Optional: refocus for new entry
    inputRef.current?.focus();
  } catch (error) {
    console.error("Error adding task:", error);
    alert("Failed to add task. Try again.");
  }
};


  // 🔹 Delete task
  const handleDelete = async (id) => {
    await deleteDoc(doc(db, "tasks", id));
  };

  // 🔹 Logout
  const handleLogout = () => {
    signOut(auth);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.header}>TaskMate 📝</Text>
      <Text style={styles.subHeader}>Hello, {user.displayName || user.email}</Text>

      <View style={styles.inputRow}>
        <TextInput
          ref={inputRef}
          placeholder="Enter a new task..."
          value={task}
          onChangeText={setTask}
          style={styles.input}
          returnKeyType="done"
          onSubmitEditing={handleAddTask}
        />
        <TouchableOpacity style={styles.addButton} onPress={handleAddTask}>
          <Text style={styles.addButtonText}>＋</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        data={tasks}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <View style={styles.taskItem}>
            <TouchableOpacity onPress={() => toggleComplete(item.id, item.completed)}>
              <Text
                style={[
                  styles.taskText,
                  item.completed && {
                    textDecorationLine: "line-through",
                    color: "gray",
                  },
                ]}
              >
                {item.text}
              </Text>
            </TouchableOpacity>

            <TouchableOpacity onPress={() => handleDelete(item.id)}>
              <Text style={styles.deleteText}>🗑️</Text>
            </TouchableOpacity>
          </View>
        )}
      />

      <TouchableOpacity style={styles.logoutButton} onPress={handleLogout}>
        <Text style={styles.logoutText}>Logout</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, padding: 20, backgroundColor: "#fff" },
  header: { fontSize: 28, fontWeight: "bold", textAlign: "center", marginBottom: 5 },
  subHeader: { textAlign: "center", marginBottom: 20, color: "#666" },
  inputRow: { flexDirection: "row", alignItems: "center", marginBottom: 20 },
  input: {
    flex: 1,
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 8,
    padding: 10,
    backgroundColor: "#f9f9f9",
  },
  addButton: {
    backgroundColor: "#007AFF",
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 8,
    marginLeft: 8,
  },
  addButtonText: { color: "#fff", fontSize: 20 },
  taskItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: 12,
    borderWidth: 1,
    borderColor: "#eee",
    borderRadius: 10,
    marginBottom: 10,
    backgroundColor: "#f9f9f9",
  },
  taskText: { fontSize: 16 },
  deleteText: { fontSize: 18, color: "red" },
  logoutButton: {
    backgroundColor: "#ff3b30",
    padding: 12,
    borderRadius: 10,
    marginTop: 20,
  },
  logoutText: { color: "#fff", textAlign: "center", fontWeight: "bold" },
});
