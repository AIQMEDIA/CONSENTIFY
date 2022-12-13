import 'package:consentify/constants.dart';
import 'package:consentify/get/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

final supabaseClient = Injector.appInstance.get<SupabaseClient>();
final user = supabaseClient.auth.user();
final userEmail = user.email;

class SettingsScreen extends StatelessWidget {
  final controller = Get.find<MainController>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(controller.userData.value.email,
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.w500)),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    title: Text("Change Password"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Injector.appInstance
                          .get<SupabaseClient>()
                          .auth
                          .api
                          .resetPasswordForEmail(userEmail);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: kPrimaryColor,
                    ),
                    title: Text("Logout"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () async {
                      await Injector.appInstance
                          .get<SupabaseClient>()
                          .auth
                          .signOut();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
