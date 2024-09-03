import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';

class NfcReader {
  final StreamController<String> _tagController =
      StreamController<String>.broadcast();

  Future<void> init() async {
    await NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef != null && ndef.cachedMessage != null) {
          final payload = ndef.cachedMessage!.records.firstOrNull?.payload;
          if (payload == null) return;
          _tagController.add(String.fromCharCodes(payload!));
        }
      },
    );
  }

  Stream<String> get onTagDiscovered {
    return _tagController.stream;
  }
}
