import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thread_new/storage/get_storage.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();
      GetxStorage().writeUserInfo(userDoc['username'], userDoc['name'], userDoc['profilePic'], userDoc['id']);
      print(userDoc['username']);
      print(userDoc['username']);
    }catch(e){
      print(e);
      return;
    }
    Get.offAndToNamed("/home");
  }
}