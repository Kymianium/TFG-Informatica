import 'package:flutter/foundation.dart';

class WhenModel extends ChangeNotifier {
  var selectedIndexes = <int>[0];
  var challengeIndexes = <int>[0];

  void updateIndex(int position, int index) {
    selectedIndexes[position] = index;
    notifyListeners();
  }

  void updateChallengeIndex(int position, int index) {
    challengeIndexes[position] = index;
    notifyListeners();
  }

  void addIndex() {
    selectedIndexes.add(0);
    challengeIndexes.add(0);
    notifyListeners();
  }
}
