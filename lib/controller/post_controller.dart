import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thread_new/storage/get_storage.dart';

class PostController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userName.value = GetxStorage().readUserInfo()[0];
    name.value = GetxStorage().readUserInfo()[1];
    profileImageUrl.value = GetxStorage().readUserInfo()[2];
    id.value = GetxStorage().readUserInfo()[3];
  }
  PanelController panelController = PanelController();
  TextEditingController msgController = TextEditingController();

  RxString userName = "".obs;
  RxString name = "".obs;
  RxString profileImageUrl = "".obs;
  RxString id = "".obs;

  Future<void> postThreadMessage() async {
    try{
      if(msgController.text.isNotEmpty){
        await FirebaseFirestore.instance.collection('threads').add({
          'id': id.value,
          'senderName': userName.value,
          'message': msgController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'senderProfileImageUrl': profileImageUrl.value,
          'likes': []
        });
        msgController.clear();
        panelController.close();
      }
    }catch(e){
      rethrow;
    }
  }


}