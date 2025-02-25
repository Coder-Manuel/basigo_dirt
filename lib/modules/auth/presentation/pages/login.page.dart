import 'package:basigo_dirt/config/assets/app.images.dart';
import 'package:basigo_dirt/core/utils/size.util.dart';
import 'package:basigo_dirt/modules/auth/presentation/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  static String route = '/login_page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Image.asset(AppImages.plainLogo),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.0.h,
            Text(
              'Login',
              style: Get.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            15.0.h,
            Text(
              'Welcome, fill in your credentials to proceed',
              style: Get.textTheme.headlineSmall,
            ),
            20.0.h,
            TextFormField(
              controller: controller.emailCTRL,
              validator: (v) {
                if (v?.isEmail == false) {
                  return 'Invalid Email';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                label: Text('Email'),
                hintText: 'Enter Email Address',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            20.0.h,
            Obx(
              () {
                return TextFormField(
                  controller: controller.passwordCTRL,
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePasswordVisibility,
                      child: Icon(
                        controller.showPassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                );
              },
            ),
            50.0.h,
            ElevatedButton(
              onPressed: () async => await controller.login(),
              style: Get.theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStatePropertyAll(Size(Get.width, 45)),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
