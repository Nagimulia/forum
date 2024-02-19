import 'package:flutter/material.dart';
import 'package:forum/controllers/authentication.dart';
import 'package:forum/views/login_page.dart';
import 'package:forum/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
              'Registration',
              style: GoogleFonts.podkova(fontSize: 30),
            ),
            SizedBox(height: 30),
            InputWidget(
              hintText: 'Name',
              obscureText: false,
              controller: _nameController,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Username',
              obscureText: false,
              controller: _usernameController,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              onPressed: () async {
                await _authenticationController.register(
                  name: _nameController.text.trim(),
                  username: _usernameController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              child: Obx(() {
                return _authenticationController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Register',
                        style: GoogleFonts.podkova(
                          fontSize: 18,
                        ),
                      );
              }),
            ),
            SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Get.to(() => LoginPage());
                },
                child: Text('Do you have a login?',
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
