import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thread_new/model/user.dart';
import '../model/suggested_followers.dart';

class SuggestedFollowerWidget extends StatelessWidget {

  const SuggestedFollowerWidget({super.key, required this.follower, this.follow, this.unFollow});
  final follow;
  final unFollow;
  final UserModel follower;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(follower.profileImageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU"),
          ),
          title: Text(follower.name),
          subtitle: Text(follower.username.toLowerCase()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   width: 110,
              //   height: 35,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: follower.isFollowing ? Text("Following", style: TextStyle(color: Colors.grey),) : Text("Follow"),
              // )

            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
