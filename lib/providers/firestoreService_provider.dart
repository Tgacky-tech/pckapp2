import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/services/firestore_service.dart';
// FirestoreServiceプロバイダー
final firestoreServiceProvider = Provider((ref) => FirestoreService());