import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thread_new/pages/post_panel.dart';

import '../controller/home_page_controller.dart';
import '../controller/post_controller.dart';

class HomePageBinding implements Bindings{
  @override
  void dependencies(){
    Get.put<HomeController>(HomeController());
    Get.put<PostController>(PostController());

  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _homeCtrl =Get.find<HomeController>();
    final _postCtrl = Get.find<PostController>();

    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          controller: _postCtrl.panelController,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          panelBuilder: (ScrollController sc) {
            return PostPanel();
          },
          body: Navigator(
            key: Get.nestedKey(1),
            initialRoute: '/feed',
            onGenerateRoute: _homeCtrl.onGenerateRoute,
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: _homeCtrl.currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index){
          if(index == 2){
            _postCtrl.panelController.isPanelOpen ? _postCtrl.panelController.close() : _postCtrl.panelController.open();
          }else{
            _homeCtrl.change(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'post'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      ),
    );
  }
}

