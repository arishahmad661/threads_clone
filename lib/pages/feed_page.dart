import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread_new/Widgets/ThreadMessageWidget.dart';
import 'package:thread_new/model/thread_message.dart';
import '../controller/feed_controller.dart';

class FeedBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<FeedController>(FeedController());
  }
}

class FeedPage extends StatelessWidget {
  FeedPage({super.key});
  final _feedCtrl = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return ThreadMessageWidget(message: message);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
