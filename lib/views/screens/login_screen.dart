import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repo/controllers/login_controller.dart';
import 'package:repo/core/shared/colors.dart';
import 'package:repo/core/shared/assets.dart';
import 'package:repo/core/utils/formatting.dart';
import 'package:repo/core/routes/routes.dart';
import 'package:repo/models/user/user.dart';
import 'package:repo/views/widgets/banner_widget.dart';
import 'package:repo/views/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:repo/views/widgets/text_field_widget.dart';
import 'package:repo/views/widgets/snackbar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  nullHandler() {
    bool isFilled = true;
    if (_emailController.text == '' || _passwordController.text == '') {
      snackbarRepo('Warning!', 'Email/Password Tidak Boleh Kosong!');
      isFilled = false;
    }
    return isFilled;
  }

  emailHandler() {
    bool emailValidation =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(_emailController.text);
    if (!emailValidation) {
      snackbarRepo('Warning!', 'Email Salah!');
    }
    return emailValidation;
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => LoginController(),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(36, 36, 36, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BannerRepo(),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFieldRepo(
                  textController: _emailController,
                  hintText: 'Masukkan alamat email',
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFieldRepo(
                  textController: _passwordController,
                  hintText: 'Masukkan password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutesRepo.forgotPassword);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Lupa Kata sandi?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: hexToColor(ColorsRepo.primaryColor),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ButtonRepo(
                  text: 'Masuk',
                  backgroundColor: ColorsRepo.primaryColor,
                  changeTextColor: false,
                  onPressed: () {
                    if (nullHandler()) {
                      if (emailHandler()) {
                        UserLoginRequest request = UserLoginRequest(
                          emailUsername: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        Get.find<LoginController>().login(request);
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Belum mempunyai akun? ',
                          style: TextStyle(
                            color: hexToColor('#7C7C7C'),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'Daftar',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutesRepo.signup);
                            },
                          style: TextStyle(
                            color: hexToColor(ColorsRepo.primaryColor),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
