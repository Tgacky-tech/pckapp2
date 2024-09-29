import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/error_provider.dart';

class CounterListNotifier extends StateNotifier<List<int>> {
  CounterListNotifier() : super([]);
  void addRandomNumber(int number) {
    if (number <= 18 && !state.contains(number)) {
      state = [...state, number]..sort();
    }
  }
}
final counterListProvider =
StateNotifierProvider<CounterListNotifier,List<int>>((ref) {
  return CounterListNotifier();
});
