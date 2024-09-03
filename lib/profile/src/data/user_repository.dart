import 'package:badge_hack/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final DocumentReference _docRef;

  UserRepository({
    required String userId,
  }) : _docRef = FirebaseFirestore.instance.collection('users').doc(userId);

  Stream<User> getUserStream() {
    return Stream.value(
      User(
        handle: 'test',
        name: 'test',
        profilePictureUrl: 'test',
      ),
    );
  }

  Future<void> updateUser(User user) async {}
}
