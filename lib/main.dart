import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thread_new/firebase_options.dart';
import 'package:thread_new/pages/favourite_page.dart';
import 'package:thread_new/pages/feed_page.dart';
import 'package:thread_new/pages/homepage.dart';
import 'package:thread_new/pages/login_page.dart';
import 'package:thread_new/pages/profile_page.dart';
import 'package:thread_new/pages/search_page.dart';
import 'package:thread_new/pages/sign_up_page.dart';
import 'package:thread_new/storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Threads',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:
      // '/login',
      GetxStorage().readUserInfo()[0].isNotEmpty && GetxStorage().readUserInfo()[1].isNotEmpty && GetxStorage().readUserInfo()[2].isNotEmpty && GetxStorage().readUserInfo()[3].isNotEmpty ? '/' :  '/login',
      getPages: [
        GetPage(name: '/', page: () => HomePage(), binding: HomePageBinding()),
        GetPage(name: '/login', page: () => LoginPage(), binding: LoginScreenBinding()),
        GetPage(name: '/signUp', page: () => SignUpScreen(), binding: SignUpScreenBinding()),
        GetPage(name: '/feed', page: () => FeedPage(), binding: FeedBinding()),
        GetPage(name: '/search', page: () => SearchPage(), binding: SearchPageBinding()),
        GetPage(name: '/favourite', page: () => Favourite(), binding: FavouriteBinding()),
        GetPage(name: '/profile', page: () => Profile()),
      ],
    );
  }
}

