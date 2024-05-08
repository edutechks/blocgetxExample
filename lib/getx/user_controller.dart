// user_controller.dart
import 'package:helloworld/getx/user_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UserController extends GetxController {
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final String data = await rootBundle.loadString('assets/user.json');
    final jsonData = json.decode(data) as List;
    users.value = jsonData
        .map((user) => UserModel(
            name: user['name'],
            email: user['email'],
            image: user['image'],
            details: user['details']))
        .toList();
  }
}
