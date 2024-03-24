// users_page.dart
import 'package:flutter/material.dart';
import 'package:helloworld/getx/user_controller.dart';
import 'package:helloworld/getx/user_detail_page.dart';
import 'package:helloworld/getx/user_model.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Obx(() {
        if (userController.users.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: userController.users.length,
            itemBuilder: (context, index) {
              UserModel user = userController.users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(user.image),
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () {
                  Get.to(() => UserDetailPage(user: user));
                },
              );
            },
          );
        }
      }),
    );
  }
}
