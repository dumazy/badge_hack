import 'package:badge_hack/feed/feed.dart';
import 'package:badge_hack/locator.dart';
import 'package:badge_hack/nfc_reader.dart';
import 'package:flutter/material.dart';

class FeedViewModel with ChangeNotifier {
  final NfcReader nfcReader = locator<NfcReader>();

  List<Meeting> meetings = [];

  FeedViewModel() {
    init();
  }

  Future<void> init() async {
    _startScanning().listen((meeting) {
      meetings.add(meeting);
      notifyListeners();
    });
  }

  Stream<Meeting> _startScanning() async* {
    while (true) {
      final tag = await nfcReader.scanTag();
      yield Meeting(who: tag, whom: 'You');
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
