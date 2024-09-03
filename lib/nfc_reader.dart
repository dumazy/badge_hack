import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';

const prefix = "com.example.badge_hack-";

class NfcReader {
  Future<String> scanTag() async {
    final completer = Completer<String>();

    await NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef != null && ndef.cachedMessage != null) {
          final payload = ndef.cachedMessage!.records.firstOrNull?.payload;
          if (payload == null) return;
          final payloadString = String.fromCharCodes(payload);
          if (!payloadString.startsWith(prefix)) return;
          completer.complete(payloadString.substring(prefix.length));

          await Future.delayed(
              Duration(seconds: 4)); // hack for stopping the session too soon
          await NfcManager.instance.stopSession();
        }
      },
    );
    return completer.future;
  }

  Future<bool> writeToTag(String data) async {
    final completer = Completer<bool>();
    await NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final ndef = Ndef.from(tag);

        if (ndef != null) {
          final prefixedData = prefix + data;
          await ndef.write(NdefMessage([
            NdefRecord.createText(prefixedData),
          ]));
          completer.complete(true);
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
