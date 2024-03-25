import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../Widgets/SuggestedFollowerWidget.dart';
import '../controller/favourite_controller.dart';
import '../model/suggested_followers.dart';

class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavouriteController());
  }
}

class Favourite extends StatelessWidget {
  Favourite({super.key});
  final _favCtrl = Get.find<FavouriteController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,

            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Activity',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: Container(
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TabBar(
                  controller: _favCtrl.tabController,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  onTap: (index){
                    _favCtrl.currentIndex.value = _favCtrl.tabController.index;
                    print(index);
                  },
                  tabs: [
                    Obx(() => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: _favCtrl.currentIndex.value == 0 ? Colors.transparent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Tab(
                          text: 'All',
                        ))),
                    Obx(() => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: _favCtrl.currentIndex.value == 1 ? Colors.transparent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Tab(
                          text: 'Follows',
                        )),),
                    Obx(() => Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: _favCtrl.currentIndex.value == 2 ? Colors.transparent : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Tab(
                          text: 'Replies',
                        )),),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TabBarView(
              children: [
                // Center(child: Text,("All screen")),
                Column(
                  children: [
                    ...suggestedFollowers.map((e) => SuggestedFollowerWidget(follower: e)).toList(),
                  ],
                ),
                Center(child: Text("Nothing to see here yet")),
                Center(child: Text("Nothing to see here yet")),
              ],
            ),
          )
      ),
    );
  }
}
