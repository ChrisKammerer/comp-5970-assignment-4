import 'package:baseball_info/models/team_model.dart';

class EventModel {
  final String name;
  final String date;
  final TeamModel homeTeam;
  final TeamModel awayTeam;

  EventModel({
    required this.name,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      date: json['date'],
      homeTeam: TeamModel.fromJson(json['competitions'][0]['competitors'][0]['team']),
      awayTeam: TeamModel.fromJson(json['competitions'][0]['competitors'][1]['team']),
    );
  }
}