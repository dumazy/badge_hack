class User {
  User({
    required this.name,
    required this.handle,
    required this.profilePictureUrl,
  });

  String name;
  String handle;
  String profilePictureUrl;

  User copyWith({
    String? name,
    String? handle,
    String? profilePictureUrl,
  }) {
    return User(
      name: name ?? this.name,
      handle: handle ?? this.handle,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : '',
      handle: map['handle'] != null ? map['handle'] as String : '',
      profilePictureUrl: map['profilePictureUrl'] != null
          ? map['profilePictureUrl'] as String
          : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'handle': handle,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
