import 'package:flutter/material.dart';
import 'package:baseball_info/providers/baseball_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/team_card.dart';

class TeamSearchScreen extends StatefulWidget {
  const TeamSearchScreen({super.key});

  @override
  State<TeamSearchScreen> createState() => _TeamSearchScreenState();
}

class _TeamSearchScreenState extends State<TeamSearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Team Search")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView(
                  children: context.watch<BaseballProvider>().teams.map((team) {
                    return TeamCard(team: team);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
