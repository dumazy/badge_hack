import 'package:badge_hack/firebase_options.dart';
import 'package:badge_hack/locator.dart';
import 'package:badge_hack/nfc_reader.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLoader ??= _loadApp(context);
  }

  Future<void> _loadApp(BuildContext context) async {
    final nfcReader = locator<NfcReader>();
    await nfcReader.init();
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
          home: Scaffold(
              appBar: AppBar(
                  title: const Text('Collect your Flutter&Friends friends')),
              body: SafeArea(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return const ListTile(
                      leading: Icon(
                        Icons.flutter_dash,
                      ),
                      title: Text('Name'),
                      subtitle: Text('@handle'),
                    );
                  },
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
