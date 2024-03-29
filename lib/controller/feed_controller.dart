import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FeedController extends GetxController{
  PanelController commentPanelController = PanelController();
  RxString threadMessageId = "".obs;
  final threadCollection = FirebaseFirestore.instance.collection("threads").orderBy("timestamp",descending: true);
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> likeThreadMessage(String id) async {
    try {
      FirebaseFirestore.instance.collection("threads").doc(id).update({
        'likes': FieldValue.arrayUnion([currentUser?.uid])
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> dislikeThreadMessage(String id) async {
    try {
      FirebaseFirestore.instance.collection("threads").doc(id).update({
        'likes': FieldValue.arrayRemove([currentUser?.uid])
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}