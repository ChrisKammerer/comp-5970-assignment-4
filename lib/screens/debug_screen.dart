import 'package:flutter/material.dart';
import 'package:baseball_info/services/baseball_service.dart';

class DebugScreen extends StatefulWidget {
  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  final service = BaseballService();
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Service')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _testTeams,
                  child: const Text('Test Fetch Teams'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _testSchedule,
                  child: const Text('Test Fetch Schedule (Team ID: 1)'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _clearOutput,
                  child: const Text('Clear Output'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(
                  output.isEmpty ? 'Press a button to test...' : output,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _testTeams() async {
    setState(() => output = 'Loading teams...');
    final teams = await service.fetchTeams();
    setState(() {
      output = 'Success! Loaded ${teams.length} teams:\n\n';
      for (var team in teams) {
        output += '${team.displayName} (${team.id})\n';
      }
    });
  }

  void _testSchedule() async {
    try {
      setState(() => output = 'Loading schedule...');
      final events = await service.fetchSchedule(1);
      setState(() {
        output = 'Success! Loaded ${events.length} events:\n\n';
        for (var event in events.take(5)) {
          output += '${event.name} (${event.date})\n';
        }
        if (events.length > 5) {
          output += '\n... and ${events.length - 5} more';
        }
      });
    } catch (e) {
      setState(() => output = 'Error: $e');
    }
  }

  void _clearOutput() {
    setState(() => output = '');
  }
}
