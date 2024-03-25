import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/profile_controller.dart';
import '../model/user.dart';

class EditProfile extends StatelessWidget {
  final UserModel user;
  EditProfile({super.key, required this.user});
  final _profileCtrl = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
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
                      _profileCtrl.panelController.close();
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                ),
                Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                TextButton(
                    onPressed: (){
                      _profileCtrl.updateUserProfile();
                    },
                    child: Text("Done", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Divider(thickness: 1,),
          Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(user.name),
                          subtitle: Text('@${user.username}'),
                          trailing: InkWell(
                              onTap: (){
                                _profileCtrl.uploadPicture();
                              },
                              child: Obx(() => CircleAvatar(
                                backgroundImage: NetworkImage(_profileCtrl.profileImageUrl.value),
                              ))
                          ),
                        ),
                        ListTile(
                          title: Text('Biography'),
                          subtitle: TextFormField(
                            controller: _profileCtrl.bio,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Bio needs to be here....',
                                hintStyle: TextStyle(fontSize: 14)
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Link'),
                          subtitle: TextFormField(
                            controller: _profileCtrl.link,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'youtube.com/@${user.username}',
                                hintStyle: TextStyle(fontSize: 14)
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Private profile'),
                              Obx(() => Switch(
                                value: _profileCtrl.isChecked.value,
                                onChanged: (val) {
                                  _profileCtrl.isChecked.value = val;
                                },
                                activeColor: Colors.black,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
