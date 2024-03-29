import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../model/user.dart';

class PostCommentController extends GetxController{
  final commentController = TextEditingController();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference threadCollection = FirebaseFirestore.instance.collection('threads');
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> postComment(String threadMessageId, PanelController controller) async {
    try {
      await threadCollection.doc(threadMessageId).update({
        'comments': FieldValue.arrayUnion([
          {
            'id': currentUser!.uid,
            'text': commentController.text,
            'time': Timestamp.now().toDate()
          }
        ])
      });
      commentController.clear();
      controller.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}