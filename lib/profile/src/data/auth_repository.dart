import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  late User _user;

  Future<String> initialize() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    _user = userCredential.user!;
    return _user.uid;
  }

  Future<void> updateName(String name) async {
    await _user.updateDisplayName(name);
  }

  Future<String> getUserId() async {
    return _user.uid;
  }
}
