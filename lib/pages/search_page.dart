import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/SuggestedFollowerWidget.dart';
import '../model/suggested_followers.dart';

class SearchPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ...suggestedFollowers.map((e) => SuggestedFollowerWidget(follower: e)).toList(),

                ],
              ),
            ),
          ),
        )
    );
  }
}



