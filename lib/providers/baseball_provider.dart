import 'dart:math';

import 'package:baseball_info/models/team_model.dart';
import 'package:baseball_info/models/event_model.dart';
import 'package:baseball_info/services/baseball_service.dart';
import 'package:flutter/material.dart';
import 'package:baseball_info/models/intro_page.dart';

class BaseballProvider extends ChangeNotifier {
  List<IntroPage> intropages = [];
  List<TeamModel> teams = [];
  List<EventModel> schedule = [];
  TeamModel? selectedTeam;
  String? errorMessage;
  bool isLoadingSchedule = false;
  final baseballService = BaseballService();

  void loadIntroPages() {
    if (intropages.isNotEmpty) return;
    intropages = [
      IntroPage(
        imagePath: 'assets/images/intro1.png',
        caption: 'Welcome to Baseball Info',
      ),
      IntroPage(
        imagePath: 'assets/images/intro2.png',
        caption: 'Explore Teams',
      ),
      IntroPage(
        imagePath: 'assets/images/intro3.png',
        caption: 'Check Schedules',
      ),
    ];
    notifyListeners();
  }

  Future<void> fetchTeams() async {
    errorMessage = null;
    notifyListeners();

    try {
      teams = await baseballService.fetchTeams();
    } catch (e) {
      errorMessage = 'Failed to fetch teams';
    }

    notifyListeners();
  }

  Future<void> fetchScheduleForTeam(TeamModel team) async {
    // If we already have this team's schedule cached, don't fetch again
    if (selectedTeam?.id == team.id && schedule.isNotEmpty) {
      selectedTeam = team;
      return;
    }

    selectedTeam = team;
    schedule = [];
    isLoadingSchedule = true;
    errorMessage = null;
    notifyListeners();

    try {
      schedule = await baseballService.fetchSchedule(team.id);
    } catch (e) {
      errorMessage = 'Failed to fetch schedule';
    }

    isLoadingSchedule = false;
    notifyListeners();
  }
}
