import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController with GetSingleTickerProviderStateMixin{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
  }
  RxInt currentIndex = 0.obs;
  late TabController tabController;
}