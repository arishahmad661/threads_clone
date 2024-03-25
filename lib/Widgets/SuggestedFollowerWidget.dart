import 'package:flutter/material.dart';
import '../model/suggested_followers.dart';

class SuggestedFollowerWidget extends StatelessWidget {
  const SuggestedFollowerWidget({super.key, required this.follower});

  final SuggestedFollower follower;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(follower.profileImageUrl),
          ),
          title: Text(follower.username),
          subtitle: Text(follower.username.toLowerCase()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: 110,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: follower.isFollowing ? Text("Following", style: TextStyle(color: Colors.grey),) : Text("Follow"),
              )

            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
