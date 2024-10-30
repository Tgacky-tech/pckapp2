import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/difficulty_provider.dart';

class CounterListNotifier extends StateNotifier<List<int>> {
  final Ref ref;
  CounterListNotifier(this.ref) : super([]);
  void addRandomNumber(int number) {
    final difficulty = ref.read(difficultyProvider); // difficultyProviderの値を取得


    if (difficulty == 0) {
      if (number <= 18 && !state.contains(number)) {
        state = [...state, number]..sort();
      }
    } else {
      if (number <= 34 && !state.contains(number)) {
        state = [...state, number]..sort();
      }
    }
  }
}
final counterListProvider =
StateNotifierProvider<CounterListNotifier,List<int>>((ref) {
  return CounterListNotifier(ref);
});
