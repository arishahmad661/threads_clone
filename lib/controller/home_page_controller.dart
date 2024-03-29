import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_new/pages/feed_page.dart';
import 'package:thread_new/pages/post_panel.dart';
import 'package:thread_new/pages/search_page.dart';

import '../pages/favourite_page.dart';
import '../pages/profile_page.dart';

class HomeController extends GetxController{

  RxInt currentIndex = 0.obs;

  final pages = [
    '/feed',
    '/search',
    '/post',
    '/favourite',
    '/profile'
  ];

  void change(int index){
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/feed') {
      return GetPageRoute(
        settings: settings,
        page: () => FeedPage(),
        binding: FeedBinding(),
      );
    }


    if (settings.name == '/search') {
      return GetPageRoute(
        settings: settings,
        page: () => SearchPage(),
        binding: SearchPageBinding(),
      );
    }

    if (settings.name == '/post') {
      return GetPageRoute(
        settings: settings,
        page: () => PostPanel(),
        // binding: SettingsBinding(),
      );
    }

    if (settings.name == '/favourite') {
      return GetPageRoute(
        settings: settings,
        page: () => Favourite(),
        binding: FavouriteBinding(),
      );
    }

    if (settings.name == '/profile') {
      return GetPageRoute(
        settings: settings,
        page: () => Profile(),
          binding: ProfileBinding()
      );
    }
    return null;
  }


}