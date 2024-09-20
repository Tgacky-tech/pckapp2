import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pckapp2/providers/topUsers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ranking_screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUsersAsyncValue = ref.watch(topUsersProvider);
    final appBar = AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('ランキング'),
    );
    return Scaffold(
      appBar: appBar,
      body: topUsersAsyncValue.when(
        data: (topUsers) {
          return ListView.builder(
            itemCount: topUsers.length,
            itemBuilder: (context, index) {
              final user = topUsers[index];
              return ListTile(
                title: Text(user['username']),
                subtitle: Text('Score: ${user['score']}'),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}