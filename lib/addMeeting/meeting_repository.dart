import 'package:badge_hack/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingRepository {
  final CollectionReference meetingsCollection =
      FirebaseFirestore.instance.collection('meetings');

  Future<void> addMeeting(Meeting meeting) async {
    await meetingsCollection.add(meeting.toMap());
  }

  Stream<List<Meeting>> getMeetings() {
    return meetingsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Meeting.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
