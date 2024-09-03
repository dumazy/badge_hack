import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BadgeHackApp());
}

class BadgeHackApp extends StatefulWidget {
  const BadgeHackApp({super.key});

  @override
  State<StatefulWidget> createState() => BadgeHackAppState();
}

class BadgeHackAppState extends State<BadgeHackApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar:
              AppBar(title: const Text('Collect your Flutter&Friends friends')),
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
  }
}
