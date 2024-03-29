import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class SearchProfileController extends GetxController{
  TextEditingController search = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  RxList allUsers = <UserModel>[].obs;
  RxList filteredUsers = <UserModel>[].obs;

  void searchUsers() {
    filteredUsers.value = allUsers.where((user) {
      return user.username.toLowerCase().contains(search.text.toLowerCase());
    }).toList();
  }

  Future<void> followUser(UserModel user) async {
    await userCollection.doc(currentUser?.uid).update({
      'following': FieldValue.arrayUnion([user.id])
    });
    await userCollection.doc(user.id).update({
      'followers': FieldValue.arrayUnion([currentUser?.uid])
    });
  }

  Future<void> unFollowUser(UserModel user) async {
    await userCollection.doc(currentUser?.uid).update({
      'following': FieldValue.arrayRemove([user.id])
    });
    await userCollection.doc(user.id).update({
      'followers': FieldValue.arrayRemove([currentUser?.uid])
    });
  }
}