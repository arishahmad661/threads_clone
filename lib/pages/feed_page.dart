import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thread_new/Widgets/ThreadMessageWidget.dart';
import 'package:thread_new/Widgets/post_comment_widget.dart';
import 'package:thread_new/controller/comment_controller.dart';
import 'package:thread_new/model/thread_message.dart';
import '../controller/feed_controller.dart';

class FeedBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<FeedController>(FeedController());
    Get.put<PostCommentController>(PostCommentController());
  }
}

class FeedPage extends StatelessWidget {
  FeedPage({super.key});
  final _feedCtrl = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _feedCtrl.commentPanelController,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      panelBuilder: (ScrollController sc){
        return PostCommentScreen(controller: _feedCtrl.commentPanelController);
      },
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              children: [
                Center(child: Image.asset("assets/thread_logo.png", width: 60,)),
                Expanded(
                  child: StreamBuilder(
                    stream: _feedCtrl.threadCollection.snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return  Center(
                          child: CircularProgressIndicator(),
                        );
                      }else if(snapshot.hasError){
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      final messages = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index){
                          final messageData = messages[index].data() as Map<String, dynamic>;
                          ThreadMessage message = ThreadMessage.fromMap(messageData);
                          return ThreadMessageWidget(
                              message: message, messageId: messages[index].id, ctrl: _feedCtrl.commentPanelController,
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
