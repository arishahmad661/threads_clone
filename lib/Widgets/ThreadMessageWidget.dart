import 'package:flutter/material.dart';
import '../model/thread_message.dart';

class ThreadMessageWidget extends StatelessWidget {
  ThreadMessage message;
  ThreadMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String _getTimeDifference() {
      final now = DateTime.now();
      final difference = now.difference(message.timestamp as DateTime);
      if (difference.inMinutes < 1) {
        return 'Just Now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} mins';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} hrs';
      }
      return "${difference.inDays} days";
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(message.senderProfileImageUrl),
              radius: 25,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(message.senderName,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(_getTimeDifference()),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(message.message),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  // if(message.likes.contains(userId)){
                                  //   onDislike();
                                  // }else{
                                  //   onLike();
                                  // }
                                },
                                icon: Icon(Icons.favorite_outline)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.comment_outlined)),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/retweet.png',
                                  width: 25,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/send.png',
                                  width: 25,
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
        const Divider(),
      ],
    );
  }
}
