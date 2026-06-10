import 'package:flutter/material.dart';
import 'package:baseball_info/providers/baseball_provider.dart';
import 'package:provider/provider.dart';
import '../models/team_model.dart';

class TeamScheduleScreen extends StatelessWidget {
  final TeamModel team;
  const TeamScheduleScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${team.displayName} Upcoming Schedule',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
          maxLines: 2,
          softWrap: true,
        ),
        actions: [
          if (team.images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(team.images.first.url),
            ),
        ],
        toolbarHeight: 100,
      ),
      body: Consumer<BaseballProvider>(
        builder: (context, provider, _) {
          if (provider.isLoadingSchedule) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          if (provider.schedule.isEmpty) {
            return const Center(child: Text('No schedule available'));
          }

          return ListView.builder(
            itemCount: provider.schedule.length,
            itemBuilder: (context, index) {
              final event = provider.schedule[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(event.name),
                    subtitle: Text(event.date.toLocal().toString().substring(0, 19)),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
