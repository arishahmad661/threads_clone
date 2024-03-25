import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Widgets/ThreadMessageWidget.dart';
import '../Widgets/edit_profile_widget.dart';
import '../controller/profile_controller.dart';
import '../model/thread_message.dart';
import '../model/user.dart';
class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ProfileController>(ProfileController());
  }
}
class Profile extends StatelessWidget {
  Profile({super.key});
  final _profileCtrl = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _profileCtrl.panelController,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      panelBuilder: (ScrollController sc){
        return StreamBuilder<UserModel>(
            stream: _profileCtrl.fetchUserData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active){
                final UserModel? user = snapshot.data;
                if(user != null){
                  return EditProfile(user: user);
                }else{
                  return Center(
                    child: Text("No User"),
                  );
                }
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
        );
      },
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: StreamBuilder<UserModel>(
                    stream: _profileCtrl.fetchUserData(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.active){
                        final UserModel? user = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(user!.name),
                              subtitle: Text('@${user?.username}'),
                              contentPadding: EdgeInsets.all(0),
                              trailing: user?.profileImageUrl != null ?
                              CircleAvatar(
                                backgroundImage: NetworkImage(user?.profileImageUrl ?? ""),
                                radius: 25,
                              )
                                  : CircleAvatar(
                                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU'),
                                radius: 25,
                              ),
                            ),
                            Text(user.bio ?? "Bio needs to be here..."),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text("100 followers", style: TextStyle(color: Colors.grey),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(_profileCtrl.panelController.isPanelClosed) _profileCtrl.panelController.open();
                                      else _profileCtrl.panelController.close();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Text("Edit Profile"),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){},
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Text("Share Profile"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25,),
                            TabBar(
                                dividerColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                labelColor: Colors.black,
                                indicatorColor: Colors.black,
                                tabs: [
                                  Tab(text: "Threads",),
                                  Tab(text: "Replies",),
                                  Tab(text: "Repost",),
                                ]),
                            Expanded(
                                child: TabBarView(
                                  children: [
                                    StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('threads')
                                          .where('id', isEqualTo: user.id).snapshots(),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData){
                                          final messages = snapshot.data!.docs;
                                          return ListView.builder(
                                            itemCount: messages.length,
                                            itemBuilder: (context, index){
                                              final messageData = messages[index].data() as Map<String, dynamic>;
                                              ThreadMessage message = ThreadMessage.fromMap(messageData);
                                              return ThreadMessageWidget(message: message);
                                                // ThreadMessageWidget(
                                                // message: messageData,
                                                // comments: threadMessage[index].comments,
                                                // likes: threadMessage[index].likes,
                                                // senderName: messageData!.senderName,
                                                // senderProfileImageUrl: messageData?.senderProfileImageUrl ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz8cLf8-P2P8GZ0-KiQ-OXpZQ4bebpa3K3Dw&usqp=CAU",
                                                // message: messageData!.message,
                                                // timestamp: messageData!.timestamp, id: '',
                                                // likes: [],
                                                // onDislike: _profileCtrl.dislikeThreadMessage(_profileCtrl.currentUser!.uid),
                                                // onLike: _profileCtrl.dislikeThreadMessage(_profileCtrl.currentUser!.uid),
                                                // comment: [],
                                              // );
                                            },
                                          );
                                        }
                                        else if(snapshot.hasError){
                                          return Center(
                                            child: Text("Error: ${snapshot.error}"),
                                          );
                                        }
                                        else{
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                    Center(
                                      child: Text("Your replies are here"),
                                    ),
                                    Center(
                                      child: Text("Your repost are here"),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        );
                      }
                      else{
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              )
          ),
        ),
      ),
    );
  }
}
