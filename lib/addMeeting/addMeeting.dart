import 'dart:ui';

import 'package:badge_hack/UI/radar.dart';
import 'package:badge_hack/UI/theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';

class Addmeeting extends StatefulWidget {
  const Addmeeting({Key? key}) : super(key: key);

  @override
  State<Addmeeting> createState() => _AddmeetingState();
}

class _AddmeetingState extends State<Addmeeting> {
  final FriendFinderChangeNotifier friendFinder = FriendFinderChangeNotifier();

  bool fastMode = false;
  Timer? _fastModeTimer;

  @override
  void initState() {
    super.initState();
    friendFinder.startLookingForFriends();
  }

  @override
  void dispose() {
    _fastModeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const height = 250.0;
    const width = 250.0;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListenableBuilder(
                listenable: friendFinder,
                builder: (context, child) {
                  String message;
                  switch (friendFinder.state) {
                    case FriendFinderState.looking:
                      message = "Hang on, we are looking!";
                      break;
                    case FriendFinderState.found:
                      message = "Friend found!";
                      if (_fastModeTimer == null) {
                        _fastModeTimer = Timer(const Duration(seconds: 2), () {
                          setState(() {
                            fastMode = true;
                          });
                        });
                      }
                      break;
                    case FriendFinderState.failedAfterOneMinute:
                      message = "No friends found nearby.";
                      break;
                    default:
                      message = "Ready to start looking?";
                  }
                  return Text(
                    message,
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              ),
            ),
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Center(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 25,
                        sigmaY: 25,
                        tileMode: TileMode.decal,
                      ),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          "assets/map_dark.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                            "assets/map_dark.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: RadarPainter(
                      height: height,
                      width: width,
                      color: AppColors.primaryPink,
                      fastMode: fastMode,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FriendFinderState {
  none,
  looking,
  found,
  failedAfterOneMinute,
}

class FriendFinderChangeNotifier extends ChangeNotifier {
  FriendFinderState _state = FriendFinderState.none;
  Timer? _timer;
  StreamSubscription? _friendStreamSubscription;

  FriendFinderState get state => _state;

  void startLookingForFriends() {
    if (_state == FriendFinderState.looking) return;

    _state = FriendFinderState.looking;
    notifyListeners();

    // Start a timer for one minute
    _timer = Timer(const Duration(minutes: 1), () {
      if (_state == FriendFinderState.looking) {
        _state = FriendFinderState.failedAfterOneMinute;
        notifyListeners();
        _stopLooking();
      }
    });

    // Start listening to the friend stream
    // _friendStreamSubscription = _getFriendStream().listen((friend) {
    //   if (friend != null) {
    //     _fetchAndAddFriendToMeetings(friend);
    //     _state = FriendFinderState.found;
    //     notifyListeners();
    //     _stopLooking();
    //   }
    // });
  }

  void _stopLooking() {
    _timer?.cancel();
    _friendStreamSubscription?.cancel();
  }

  Stream<Map<String, dynamic>?> getFriendStream() {
    // Implement your logic to get a stream of potential friends
    // This is a placeholder and should be replaced with your actual implementation
    return Stream.periodic(const Duration(seconds: 5), (value) => {});
  }

  Future<void> _fetchAndAddFriendToMeetings(Map<String, dynamic> friend) async {
    // try {
    //   // Fetch friend's profile from Firestore
    //   DocumentSnapshot friendProfile = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(friend['id'])
    //       .get();

    //   // Add friend to meetings collection
    //   await FirebaseFirestore.instance.collection('meetings').add({
    //     'friendId': friend['id'],
    //     'friendProfile': friendProfile.data(),
    //     'timestamp': FieldValue.serverTimestamp(),
    //   });
    // } catch (e) {
    //   print('Error fetching and adding friend to meetings: $e');
    // }
  }

  @override
  void dispose() {
    _stopLooking();
    super.dispose();
  }
}
