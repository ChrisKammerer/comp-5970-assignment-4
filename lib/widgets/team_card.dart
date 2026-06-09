import 'package:flutter/material.dart';
import 'package:baseball_info/providers/baseball_provider.dart';
import 'package:provider/provider.dart';
import '../screens/team_schedule_screen.dart';
import '../models/team_model.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  const TeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: team.images.isNotEmpty
            ? Image.network(team.images.first.url, width: 50, height: 50)
            : null,
        title: Text(team.displayName),
        onTap: () {
          context.read<BaseballProvider>().fetchScheduleForTeam(team);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamScheduleScreen(team: team),
            ),
          );
        },
      ),
    );
  }
}
