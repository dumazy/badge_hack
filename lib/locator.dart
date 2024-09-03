import 'package:badge_hack/nfc_reader.dart';
import 'package:badge_hack/profile/src/data/auth_repository.dart';
import 'package:badge_hack/profile/src/data/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'addMeeting/meeting_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<NfcReader>(() => NfcReader());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<MeetingRepository>(() => MeetingRepository());
}
