import 'package:badge_hack/locator.dart';
import 'package:badge_hack/nfc_reader.dart';
import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier {
  final NfcReader nfcReader = locator<NfcReader>();

  final TextEditingController nameController = TextEditingController();

  bool unsavedChanges = false;

  ProfileViewModel() {
    nameController.addListener(() {
      unsavedChanges = true;
      notifyListeners();
    });
  }


  Future<void> save() async {
    
    unsavedChanges = false;
    notifyListeners();
  }
  

  
}
