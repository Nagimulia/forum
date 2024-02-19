import 'package:flutter/material.dart';
import 'package:forum/controllers/authentication.dart';
import 'package:forum/views/registration_page.dart';
import 'package:forum/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: GoogleFonts.podkova(fontSize: 30),
            ),
            SizedBox(height: 30),
            InputWidget(
              hintText: 'Username',
              obscureText: false,
              controller: _usernameController,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                await _authenticationController.login(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim());
              },
              child: Obx(() {
                return _authenticationController.isLoading.value
                    ? CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : Text(
                        'Login',
                        style: GoogleFonts.podkova(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
              }),
            ),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Get.to(() => RegistrationPage());
                },
                child: Text('Register',
                    style: GoogleFonts.podkova(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )))
          ],
        ),
      ),
    );
  }
}
