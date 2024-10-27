import 'package:flutter_riverpod/flutter_riverpod.dart';

class TutorialNotifier extends StateNotifier<int> {
  TutorialNotifier() : super(0);

  void setTutorial(int step) {
    state = step;
  }

  void resetTutorial() {
    state = 0;
  }
}


final tutorialProvider = StateNotifierProvider<TutorialNotifier, int>((ref) {
  return TutorialNotifier();
});