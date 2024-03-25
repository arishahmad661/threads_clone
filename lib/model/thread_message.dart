// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ThreadMessage {
  final String id;
  final String senderName;
  final String senderProfileImageUrl;
  final String message;
  final DateTime timestamp;
  final List likes;
  // final List comments;

  ThreadMessage({
    required this.id,
    required this.senderName,
    required this.senderProfileImageUrl,
    required this.message,
    required this.timestamp,
    required this.likes,
    // required this.comments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderName': senderName,
      'senderProfileImageUrl': senderProfileImageUrl,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'likes': likes,
      // 'comments': comments
    };
  }

  factory ThreadMessage.fromMap(Map<String, dynamic> map) {
    return ThreadMessage(
      id: map['id'] as String,
      senderName: map['senderName'] as String,
      senderProfileImageUrl: map['senderProfileImageUrl'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] != null ? map['timestamp'].toDate() : DateTime.now(),
      likes: List.from((map['likes'] as List)),
      // comments: List.from((map['comments'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ThreadMessage.fromJson(String source) =>
      ThreadMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ThreadMessage.empty() {
    return ThreadMessage(
      id: '',
      senderName: '',
      senderProfileImageUrl: '',
      message: '',
      timestamp: DateTime.now(),
      likes: [],
      // comments: []
    );
  }
}
List<ThreadMessage> threadMessage = [
  ThreadMessage(
    id: '1',
    senderName: "sender 1",
    senderProfileImageUrl: "assets/profile.png",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),  ThreadMessage(

    id: '2',
    senderName: "sender 2",
    senderProfileImageUrl: "assets/profile_1.jpeg",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),  ThreadMessage(

    id: '3',
    senderName: "sender 3",
    senderProfileImageUrl: "assets/profile_2.jpeg",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),  ThreadMessage(

    id: '4',
    senderName: "sender 4",
    senderProfileImageUrl: "assets/profile_3.jpeg",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),  ThreadMessage(

    id: '5',
    senderName: "sender 5",
    senderProfileImageUrl: "assets/profile_4.jpeg",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),  ThreadMessage(

    id: '6',
    senderName: "sender 6",
    senderProfileImageUrl: "assets/profile_5.jpeg",
    message: "hi! how are you all today ?",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    likes: [1,2],
    // comments: [1,2]
  ),
];