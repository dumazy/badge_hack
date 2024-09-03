import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';

class NfcReader {
  final StreamController<String> _tagController =
      StreamController<String>.broadcast();

  Future<void> init() async {
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        print('tag discovered: ${tag.data}');
        _tagController.add(tag.data['test'] as String);
      },
    );
  }

  Stream<String> get onTagDiscovered {
    return _tagController.stream;
  }
}
