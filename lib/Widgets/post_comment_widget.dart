import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thread_new/controller/comment_controller.dart';
import 'package:thread_new/controller/feed_controller.dart';
import 'package:thread_new/storage/get_storage.dart';
import '../model/user.dart';

class PostCommentScreen extends StatelessWidget {
  PanelController controller;
  PostCommentScreen({super.key, required this.controller});
  @override
  final _feedCtrl = Get.find<FeedController>();
  final _commentCtrl = Get.find<PostCommentController>();

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.close();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                'Reply',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              TextButton(
                onPressed: () {
                  _commentCtrl.postComment(_feedCtrl.threadMessageId.value, controller);
                },
                child: const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),

        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(GetxStorage().readUserInfo()[2]),
          ),
          title: Text(
            GetxStorage().readUserInfo()[0],
            style: const TextStyle(fontSize: 14),
          ),
          subtitle: TextFormField(
            controller: _commentCtrl.commentController,
            decoration: InputDecoration(
                hintText: 'Reply to User.name',
                hintStyle: const TextStyle(fontSize: 13),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
