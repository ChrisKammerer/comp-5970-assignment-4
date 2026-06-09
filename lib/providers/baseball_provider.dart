import 'dart:math';

import 'package:baseball_info/models/team_model.dart';
import 'package:baseball_info/services/baseball_service.dart';
import 'package:flutter/material.dart';
import 'package:baseball_info/models/intro_page.dart';

class BaseballProvider extends ChangeNotifier {
  List<IntroPage> intropages = [];
  List<TeamModel> teams = [];
  String? errorMessage;
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
}
