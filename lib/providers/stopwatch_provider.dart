import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// Stopwatchの状態を管理するプロバイダー
class StopwatchState {
  final Stopwatch stopwatch;
  final bool isRunning;

  StopwatchState(this.stopwatch, this.isRunning);
}

final stopwatchProvider = StateNotifierProvider<StopwatchNotifier, StopwatchState>((ref) {
  return StopwatchNotifier();
});

class StopwatchNotifier extends StateNotifier<StopwatchState> {
  StopwatchNotifier() : super(StopwatchState(Stopwatch(), false)) {
    _startTicker();
  }

  late Timer _ticker;

  void _startTicker() {
    _ticker = Timer.periodic(Duration(milliseconds: 100), (_) {
      if (state.isRunning) {
        state = StopwatchState(state.stopwatch, true);
      }
    });
  }

  void start() {
    state.stopwatch.start();
    state = StopwatchState(state.stopwatch, true);
  }

  void stop() {
    state.stopwatch.stop();
    state = StopwatchState(state.stopwatch, false);
  }

  void reset() {
    state.stopwatch.reset();
    state = StopwatchState(state.stopwatch, false);
  }

  Duration get elapsedTime => state.stopwatch.elapsed;

  String get formattedElapsedTime {
    final seconds = elapsedTime.inSeconds % 60;
    final minutes = (elapsedTime.inMinutes % 60);
    final hours = (elapsedTime.inHours);
    return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}