import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kriscent_socail_media/controllers/auth/auth_controller.dart';
import 'package:kriscent_socail_media/view/screens/home/home_page.dart';
import 'package:kriscent_socail_media/view/screens/auth/sign_up_screen.dart';
import 'package:kriscent_socail_media/view/utils/app_widgets/buttons/custom_button.dart';
import 'package:kriscent_socail_media/view/utils/sizes/size.dart';
import '../../utils/app_widgets/textfields/custom_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Login Here',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: textBoldFont),
              ),
              const Spacer(),
              CustomTextFiled(
                controller: controller.emailController,
                hint: 'Email',
                iconData: Icons.mail,
              ),
              CustomTextFiled(
                controller: controller.passwordController,
                hint: 'Password',
                iconData: Icons.lock,
                toHide: true,
              ),
              const Spacer(
                flex: 1,
              ),
              CustomButton(
                  onPressed: controller.login,
                  isLoading: controller.isLoading,
                  text: 'Login'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: controller.onSignUpTap,
                    child: const Text(
                      'Sign Up Here',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              )
            ],
          );
        }),
      ),
    );
  }
}
