import 'package:firebase_core/firebase_core.dart';

class ProfileService {
  // Future<void> initialize() async {
  //   userId = await _authRepository.initialize();
  //   _userRepository = locator<UserRepository>(param1: userId);
  //   final completer = Completer<void>();
  //   // TODO keep streamsubscription to close when the service is disposed, e.g. when the user logs out
  //   _userRepository.getUserStream().listen(
  //     (user) {
  //       if (!completer.isCompleted) {
  //         completer.complete();
  //       }
  //       _userSubject.add(user);
  //     },
  //   );
  //   await completer.future;
  // }

  Future<void> updateUsername(String name) async {}
}
