import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thread_new/storage/get_storage.dart';

import '../model/thread_message.dart';
import '../model/user.dart';

class ProfileController extends GetxController{
  PanelController panelController = PanelController();
  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController bio = TextEditingController();
  TextEditingController link = TextEditingController();
  RxString profileImageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU".obs;
  RxBool isChecked = false.obs;


  Stream<UserModel> fetchUserData() {
    return FirebaseFirestore.instance.collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>));
  }

  Future<void> updateUserProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .set({
        'bio': bio.text,
        'link': link.text,
        'profileImageUrl': profileImageUrl.value,
      }, SetOptions(merge: true));

      panelController.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future uploadPicture() async {
    final status = await [Permission.storage, Permission.photos].request();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final file = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance.ref().child('profile_image/${currentUser?.uid}.jpg');
      try{
        final upload = storageRef.putFile(file);
        final snapshot = await upload.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        profileImageUrl.value = downloadUrl;
        GetxStorage().updateProfilePic(profileImageUrl.value);
      }catch(e){
        print("////");
        debugPrint(e.toString());
        print("////");
      }
    }
  }



}