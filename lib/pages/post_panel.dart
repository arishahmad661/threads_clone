import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread_new/storage/get_storage.dart';

import '../controller/post_controller.dart';

class PostPanel extends StatelessWidget {
  const PostPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final _postCtrl = Get.find<PostController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: (){
                      _postCtrl.panelController.close();
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                ),
                Text("New Thread", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                TextButton(
                    onPressed: (){
                      _postCtrl.postThreadMessage();
                    },
                    child: Text("Post", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Divider(thickness: 1,),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(_postCtrl.profileImageUrl.value),
                  radius: 25,
                ),
                SizedBox(width: 14,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => Text(_postCtrl.userName.value, style: TextStyle(fontWeight: FontWeight.bold),),),
                    TextFormField(
                      controller: _postCtrl.msgController,
                      decoration: InputDecoration(
                          hintText: 'Start a thread...',
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none
                      ),
                      maxLines: null,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
