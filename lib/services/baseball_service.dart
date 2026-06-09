import 'package:baseball_info/models/event_model.dart';
import 'package:baseball_info/models/team_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseballService {
  static const String baseUrl =
      'https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/';

  Future<List<TeamModel>> fetchTeams() async {
    final url = Uri.parse('${baseUrl}teams');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final teams = data['sports'][0]['leagues'][0]['teams'] as List;
      return teams.map((team) => TeamModel.fromJson(team['team'])).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<List<EventModel>> fetchSchedule(String id) async {
    final url = Uri.parse('${baseUrl}teams/$id/schedule');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final events = data['events'] as List;
      return events.map((event) => EventModel.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }
}
