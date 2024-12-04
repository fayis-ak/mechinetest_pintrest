import 'package:flutter/material.dart';

class WalpepperProvider with ChangeNotifier {
  int currentindex = 0;

  void updateindex(int index) {
    currentindex = index;
    notifyListeners();
  }

  int selectedTopic = 0;
  void selected(int index) {
    selectedTopic = index;
    notifyListeners();
  }
}
