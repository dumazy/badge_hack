import 'package:badge_hack/UI/theme.dart';
import 'package:badge_hack/feed/feed.dart';
import 'package:badge_hack/firebase_options.dart';
import 'package:badge_hack/locator.dart';
import 'package:badge_hack/nfc_reader.dart';
import 'package:badge_hack/profile/profile.dart';
import 'package:badge_hack/profile/src/data/auth_repository.dart';
import 'package:badge_hack/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BadgeHackApp());
}

class BadgeHackApp extends StatefulWidget {
  const BadgeHackApp({super.key});

  @override
  State<StatefulWidget> createState() => BadgeHackAppState();
}

class BadgeHackAppState extends State<BadgeHackApp> {
  Future<void>? _appLoader;

  @override
  void initState() {
    super.initState();
    _appLoader ??= _loadApp();
  }

  Future<void> _loadApp() async {
    final authRepository = locator<AuthRepository>();
    await authRepository.initialize();
    final userId = await authRepository.getUserId();
    final userRepository = locator<UserRepository>();
    await userRepository.initialize(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _appLoader,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return MaterialApp(
          theme: appTheme(),
          home: Feed(),
        );
      },
    );
  }
}
