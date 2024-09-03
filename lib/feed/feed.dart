import 'package:badge_hack/feed/feed_viewmodel.dart';
import 'package:badge_hack/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  final meetings = [
    Meeting(who: 'Simon', whom: 'Lisa'),
    Meeting(who: 'Leaon', whom: 'Adem'),
    Meeting(who: 'Nina', whom: 'Osman'),
    Meeting(who: 'Simon', whom: 'Lisa'),
    Meeting(who: 'Lisa', whom: 'Brian'),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedViewModel>(
        create: (_) => FeedViewModel(),
        builder: (context, _) {
          final viewModel = context.watch<FeedViewModel>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Feed',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.of(context).push(ProfileScreen.route());
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final meeting = viewModel.meetings[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 48,
                    ),
                    title: Row(
                      children: [
                        Text(
                          meeting.who,
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'just met',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          meeting.whom,
                          style: const TextStyle(
                            color: Colors.teal,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                  );
                },
                itemCount: viewModel.meetings.length,
              ),
            ),
            backgroundColor: Colors.black,
          );
        });
  }
}

class Meeting {
  Meeting({required this.who, required this.whom});

  String who;
  String whom;
}
