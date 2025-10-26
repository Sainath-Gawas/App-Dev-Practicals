import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calculation_model.dart';
import 'database_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Calculation>> _history;

  @override
  void initState() {
    super.initState();
    _refreshHistory();
  }

  void _refreshHistory() {
    setState(() {
      _history = DatabaseHelper.instance.readAllHistory();
    });
  }

  String _formatTimestamp(String isoString) {
    final dateTime = DateTime.parse(isoString);
    return DateFormat('yyyy-MM-dd – hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        backgroundColor: Colors.deepPurple,

        // 1. FIX: Explicitly define the LEADING back button with Font Awesome
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.arrowLeft, // Font Awesome back arrow
            size: 20,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () =>
              Navigator.of(context).pop(), // Correct navigation pop
        ),

        actions: [
          // 2. FIX: Corrected typo (IconButton) and uses Font Awesome delete icon
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.trashCan, // Font Awesome delete/trash can
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Clear History'),
                  content: const Text(
                      'Are you sure you want to delete all history?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete')),
                  ],
                ),
              );

              if (confirm ?? false) {
                // This relies on the method defined below
                await DatabaseHelper.instance.clearHistory();
                _refreshHistory(); // Refresh the history after clearing
              }
            },
          )
        ],
      ),
      body: FutureBuilder<List<Calculation>>(
        future: _history,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(child: Text('No history available.'));
          }

          return ListView.separated(
            itemCount: history.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = history[index];

              return ListTile(
                title: Text(item.expression),
                subtitle: Text('= ${item.result}'),
                trailing: Text(
                  _formatTimestamp(item.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
