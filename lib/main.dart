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

  final users = [
    User(
      name: 'Name',
      handle: '@handle',
      profilePictureUrl: 'https://avatars.githubusercontent.com/u/2174500?v=4',
    ),
    User(
      name: 'Name 42',
      handle: '@handle42',
      profilePictureUrl: 'https://avatars.githubusercontent.com/u/744771?v=4',
    ),
    User(
      name: 'Name 4711',
      handle: '@handle4711',
      profilePictureUrl:
          'https://avatars.githubusercontent.com/u/1919067?s=64&v=4',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _appLoader ??= _loadApp();
  }

  Future<void> _loadApp() async {
    final nfcReader = locator<NfcReader>();
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
        return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                  title: const Text('Collect your Flutter&Friends friends')),
              body: SafeArea(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            users[index].profilePictureUrl,
                          )),
                      title: Text(users[index].name),
                      subtitle: Text(users[index].handle),
                      tileColor: Colors.lightBlueAccent,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                    );
                  },
                  itemCount: users.length,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.search),
              )),
        );
      },
    );
  }
}
