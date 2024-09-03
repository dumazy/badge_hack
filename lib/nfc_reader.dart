import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';

class NfcReader {
  Future<String> scanTag() async {
    final completer = Completer<String>();

    await NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef != null && ndef.cachedMessage != null) {
          final payload = ndef.cachedMessage!.records.firstOrNull?.payload;
          if (payload == null) return;
          completer.complete(String.fromCharCodes(payload));
          await Future.delayed(
              Duration(seconds: 4)); // hack for stopping the session too soon
          await NfcManager.instance.stopSession();
        }
      },
    );
    return completer.future;
  }

  Future<void> writeToTag(String data) async {
    final completer = Completer<void>();
    await NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef != null) {
          await ndef.write(NdefMessage([
            NdefRecord.createText(data),
          ]));
          completer.complete();
          await Future.delayed(
            Duration(seconds: 4),
          ); // hack for stopping the session too soon
          await NfcManager.instance.stopSession();
        }
      },
    );
    return completer.future;
  }
}
