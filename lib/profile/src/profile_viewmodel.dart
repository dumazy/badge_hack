import 'package:badge_hack/debouncer.dart';
import 'package:badge_hack/locator.dart';
import 'package:badge_hack/nfc_reader.dart';
import 'package:badge_hack/profile/src/data/auth_repository.dart';
import 'package:badge_hack/profile/src/data/user_repository.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  final NfcReader nfcReader = locator<NfcReader>();
  final AuthRepository authRepository = locator<AuthRepository>();
  final UserRepository userRepository = locator<UserRepository>();

  final TextEditingController nameController = TextEditingController();
  final _nameDebouncer = Debouncer(milliseconds: 1000);

  bool unsavedChanges = false;
  bool writing = false;

  ProfileViewModel() {
    init();
  }

  Future<void> init() async {
    nameController.addListener(() {
      unsavedChanges = true;
      _nameDebouncer.run(() {
        unsavedChanges = false;
        save();
        notifyListeners();
      });
    });
    final user = await userRepository.getUser();
    nameController.text = user.name;
  }

  Future<void> save() async {
    final name = nameController.text;
    await userRepository.updateName(name);

    unsavedChanges = false;
    notifyListeners();
  }

  /// Write the user id to the NFC tag.
  Future<void> writeTag() async {
    writing = true;
    notifyListeners();
    try {
      final userId = await authRepository.getUserId();
      await nfcReader.writeToTag(userId);
    } finally {
      writing = false;
      notifyListeners();
    }
  }
}
