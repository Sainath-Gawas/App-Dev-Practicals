import 'dart:io';

void main() {
  // Ask the user for the number of terms
  stdout.write("Enter the number of Fibonacci terms to display: ");
  String? input = stdin.readLineSync();
  int n = int.tryParse(input ?? '') ?? 0;

  int a = 0, b = 1;

  print("\nFibonacci Series up to $n terms:");

  for (int i = 0; i < n; i++) {
    print(a);
    int next = a + b;
    a = b;
    b = next;
  }
}
