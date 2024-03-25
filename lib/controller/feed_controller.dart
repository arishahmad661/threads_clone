import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FeedController extends GetxController{
  final threadCollection = FirebaseFirestore.instance.collection("threads").orderBy("timestamp",descending: true);

}