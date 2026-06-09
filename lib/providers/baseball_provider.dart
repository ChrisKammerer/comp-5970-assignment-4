import 'dart:math';

import 'package:flutter/material.dart';
import 'package:baseball_info/models/intro_page.dart';

class BaseballProvider extends ChangeNotifier {
  List<IntroPage> intropages = [];

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
}