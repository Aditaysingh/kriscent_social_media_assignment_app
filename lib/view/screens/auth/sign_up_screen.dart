import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/auth/auth_controller.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/buttons/custom_button.dart';
import 'package:kriscent_socail_media/view/utils/extensions/app_extensions.dart';
import 'package:kriscent_socail_media/view/utils/sizes/size.dart';
import '../../utils/app_widgets/textfields/custom_textfiled.dart';
import '../../utils/app_widgets/pickers/image_picker_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var sizes = AppSizes(context: context);
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
         () {
          return ListView(
            children: [
              Center(
                child: ImagePickerWidget(
                  image: controller.imageFile,
                  onImagePicked: (File? pickedImage) {
                    controller.updateImageFile(pickedImage);
                  }, networkUrl: null,
                ),
              ),
              SizedBox(height: sizes.getHeight * 0.02),
              CustomTextFiled(
                  controller: controller.nameController,
                  iconData: Icons.drive_file_rename_outline,
                  hint: 'Name'),
              CustomTextFiled(
                  controller: controller.emailController,
                  iconData: Icons.mail,
                  hint: 'Email'),
              CustomTextFiled(
                  controller: controller.passwordController,
                  iconData: Icons.password,
                  hint: 'Password'),
              CustomTextFiled(
                  controller: controller.phoneController,
                  iconData: Icons.phone_android,
                  hint: 'Phone'),
              20.height,
              CustomButton(
                text: 'Sign Up',
                onPressed: controller.signUp,
                isLoading:controller.isLoading
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: controller.onLoginTap,
                    child: const Text(
                      'Login Here',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}