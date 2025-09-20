let fruits = ["apple", "banana", "cherry", "Mango"];  // Array creation
fruits.push("orange"); // Adding an element to the end
console.log(fruits); //printing the array
fruits.unshift("grape");// Adding an element to the beginning
console.log(fruits);
fruits.pop(); // Removing the last element
console.log(fruits);

console.log(fruits.indexOf("banana")); // Finding the index of an element
console.log(fruits.length); // Getting the length of the array
console.log(fruits[3]);

// Iterating over the array
for (let i = 0; i < fruits.length; i++) {
    console.log(i, fruits[i]);
}

fruits[1] = "kiwi"; // Modifying an element
console.log(fruits);

fruits.shift(); // Removing the first element
console.log(fruits);