class User {
  User({
    required this.name,
  });

  String name;

  User copyWith({
    String? name,
    String? handle,
    String? profilePictureUrl,
  }) {
    return User(
      name: name ?? this.name,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
