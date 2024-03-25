import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/get_storage.dart';

class SignUpController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Future<void> signUp() async{
    try{
      if(emailController.text.isEmpty && passwordController.text.isEmpty && nameController.text.isEmpty && userNameController.text.isEmpty){
        return ;
      }
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set(
          {
            'id': userId,
            'name': nameController.text.trim(),
            'username': userNameController.text,
            'following': [],
            'followers': [],
            'profileImageUrl': "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU",
          });
      GetxStorage().writeUserInfo(userNameController.text, nameController.text.trim(), "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU", userId);
      Get.offAndToNamed('/home');
    }catch(e){
      print("Error: ${e.toString()}");
      return ;
    }
  }
}
