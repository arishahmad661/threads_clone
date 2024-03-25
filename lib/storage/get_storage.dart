import 'package:get_storage/get_storage.dart';
class GetxStorage {
  final box = GetStorage();

  void writeUserInfo(String userName, String name, String profilePic, String id) {
    box.write('userName', userName);
    box.write('fullName', name);
    box.write('profilePic', profilePic);
    box.write('id', id);
    print(userName);
    print(name);
    print(profilePic);
    print(id);
  }
  void updateProfilePic(String profilePic,){
    box.write('profilePic', profilePic);
  }

  List<String> readUserInfo() {
    print(box.read('userName'),);
    print(box.read('fullName'),);
    print(box.read('profilePic'),);
    print(box.read('id'),);
    return [
      box.read('userName'),
      box.read('fullName'),
      box.read('profilePic'),
      box.read('id'),
    ];
  }
}