import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
FutureProvider<SharedPreferences>((ref) async {
  // SharedPreferences.setMockInitialValues({});
  return SharedPreferences.getInstance();
});