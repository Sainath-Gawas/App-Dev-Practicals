import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator + Firestore'),
      ),
      body: Column(
        children: [
          // Display
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            color: Colors.grey[200],
            height: 100,
            child: Text(
              input,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          // Buttons
          buildButtons(),
          const Divider(height: 1),
          // History
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('calculations')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;

                if (docs.isEmpty)
                  return const Center(child: Text('No history found.'));

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    return ListTile(
                      title: Text('${doc['expression']} = ${doc['result']}'),
                      subtitle: Text(DateFormat('yyyy-MM-dd HH:mm')
                          .format(doc['timestamp'].toDate())),
                      trailing: ElevatedButton(
                        child: const Text('Delete'),
                        onPressed: () => doc.reference.delete(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    final buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['0', '.', '=', '+'],
      ['C'],
    ];

    return Column(
      children: buttons.map((row) {
        return Row(
          children: row.map((text) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: ElevatedButton(
                  onPressed: () => onButtonPressed(text),
                  child: Text(text, style: const TextStyle(fontSize: 24)),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  void onButtonPressed(String text) async {
    if (text == 'C') {
      setState(() => input = '');
    } else if (text == '=') {
      try {
        final parser = Parser();
        final exp = parser.parse(input);
        final res = exp.evaluate(EvaluationType.REAL, ContextModel());

        final expressionToSave = input; // Save original expression

        setState(() => input = res.toString()); // Show result

        // Store in Firestore
        await _firestore.collection('calculations').add({
          'expression': expressionToSave,
          'result': res.toString(),
          'timestamp': Timestamp.now(),
        });
      } catch (e) {
        setState(() => input = 'Error');
      }
    } else {
      setState(() => input += text);
    }
  }
}
