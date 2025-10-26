import React, { useState, useEffect } from "react";
import { View, Text, TextInput, Button, FlatList, TouchableOpacity, StyleSheet } from "react-native";
import { db } from "./firebase";
import { collection, addDoc, onSnapshot, deleteDoc, doc, serverTimestamp } from "firebase/firestore";

export default function App() {
  const [task, setTask] = useState("");
  const [tasks, setTasks] = useState([]);

  // Reference to tasks collection
  const tasksCollectionRef = collection(db, "tasks");

  useEffect(() => {
  const unsubscribe = onSnapshot(tasksCollectionRef, (snapshot) => {
    const items = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    setTasks(items); // Only update state
  });

  return () => unsubscribe();
}, []);




 // In addTask function
const addTask = async () => {
  if (!task.trim()) return;

  const docRef = await addDoc(tasksCollectionRef, {
    name: task,
    timestamp: serverTimestamp(),
    status: "Pending", // default status
  });

  console.log(`Added '${task}'`);
  const updatedTasks = [...tasks, { id: docRef.id, name: task, status: "Pending" }];
  console.log("Current tasks:", updatedTasks.map(t => t.name).join(", "));
  setTask("");
};


const deleteTask = async (id, taskName) => {
  await deleteDoc(doc(db, "tasks", id));
  console.log(`Deleted '${taskName}'`);

  // Log current tasks after deletion
  const updatedTasks = tasks.filter(t => t.id !== id);
  console.log("Current tasks:", updatedTasks.map(t => t.name).join(", "));
};




  return (
    <View style={styles.container}>
      <Text style={styles.title}>ToDo List</Text>

      <TextInput
        placeholder="Enter a task"
        value={task}
        onChangeText={setTask}
        style={styles.input}
      />

      <Button title="Add Task" onPress={addTask} />

      <FlatList
        data={tasks.sort((a,b) => b.timestamp?.seconds - a.timestamp?.seconds)}
        keyExtractor={item => item.id}
        renderItem={({ item }) => (
          <View style={styles.taskItem}>
            <View>
              <Text style={styles.taskName}>{item.name}</Text>
              {item.timestamp && (
                <Text style={styles.timestamp}>
                  {new Date(item.timestamp.seconds * 1000).toLocaleString()}
                </Text>
              )}
            </View>
            <TouchableOpacity onPress={() => deleteTask(item.id)}>
              <Text style={styles.deleteButton}>Delete</Text>
            </TouchableOpacity>
          </View>
        )}
        style={{ marginTop: 20 }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex:1, padding:20, backgroundColor:"#f2f2f2" },
  title: { fontSize:28, fontWeight:"bold", marginBottom:20 },
  input: { borderWidth:1, borderColor:"#ccc", padding:10, marginBottom:10, borderRadius:5, backgroundColor:"#fff" },
  taskItem: { flexDirection:"row", justifyContent:"space-between", padding:15, backgroundColor:"#fff", borderRadius:5, marginBottom:10, alignItems:"center" },
  taskName: { fontSize:16 },
  timestamp: { fontSize:12, color:"#888", marginTop:2 },
  deleteButton: { color:"red", fontWeight:"bold" }
});

// Add task
const addTask = async () => {
  if (!task.trim()) return;

  const docRef = await addDoc(tasksCollectionRef, {
    name: task,
    timestamp: serverTimestamp(),
    status: "Pending"
  });

  console.log(`Added '${task}'`);
  const updatedTasks = [...tasks, { id: docRef.id, name: task, status: "Pending" }];
  console.log("Current tasks:", updatedTasks.map(t => t.name).join(", "));
  setTask("");
};

// Delete task
const deleteTask = async (id, taskName) => {
  await deleteDoc(doc(db, "tasks", id));
  console.log(`Deleted '${taskName}'`);
  const updatedTasks = tasks.filter(t => t.id !== id);
  console.log("Current tasks:", updatedTasks.map(t => t.name).join(", "));
};

