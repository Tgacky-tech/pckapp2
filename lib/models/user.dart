class User {
  final int id;
  final String username;
  final int score;

  User({required this.id, required this.username, required this.score});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      score: map['score'],
    );
  }
}