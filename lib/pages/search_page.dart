import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Widgets/SuggestedFollowerWidget.dart';
import '../controller/search_controller.dart';
import '../model/suggested_followers.dart';
import '../model/user.dart';

class SearchPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SearchProfileController());
  }
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _searchCtrl = Get.find<SearchProfileController>();


    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Search", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: double.infinity,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: _searchCtrl.search,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search)
                        ),
                        onChanged: (val){
                          _searchCtrl.searchUsers();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  SingleChildScrollView(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').where('id', isNotEqualTo: _searchCtrl.currentUser?.uid).snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }else if(snapshot.hasError){
                            return Center(
                              child: Text("Some error occured!"),
                            );
                          }
                          final users = snapshot.data!.docs;
                          _searchCtrl.allUsers.value = users.map((doc) {
                            final user = doc.data() as Map<String, dynamic>;
                            return UserModel(
                              id: user['id'],
                              username: user['username'],
                              profileImageUrl: user['profileImageUrl'],
                              name: user['name'],
                              followers: [],
                              following: [],
                            );
                          }).toList();
                          return Obx(() => ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchCtrl.filteredUsers.length,
                            itemBuilder: (contex, index) {
                              return SuggestedFollowerWidget(
                                follower: _searchCtrl.filteredUsers[index],
                                follow: () => _searchCtrl.followUser(_searchCtrl.filteredUsers[index]),
                                unFollow: () => _searchCtrl.unFollowUser(_searchCtrl.filteredUsers[index]),
                              );
                            },
                          ));
                          },
                    ),
                  )
                  // ...suggestedFollowers.map((e) => SuggestedFollowerWidget(follower: e)).toList(),

                ],
              ),
            ),
          ),
        )
    );
  }
}



