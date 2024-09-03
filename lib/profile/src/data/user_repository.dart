import 'package:badge_hack/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  late String userId;
  late final DocumentReference _docRef;

  UserRepository();

  Future<void> initialize(String userId) async {
    this.userId = userId;
    _docRef = FirebaseFirestore.instance.collection('users').doc(userId);
  }

  Future<User> getUser() async {
    final snapshot = await _docRef.get();
    return User.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateName(String name) async {
    await _docRef.set({
      'name': name,
    });
  }
}
