import 'package:finndata_project/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../widgets/button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Welcome back!",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 30, right: 20, left: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Email";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Email',
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Password";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: kTextFieldDecoration.copyWith(
                                        hintText: 'Password',
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            LoginSignupButton(
                              title: 'Login',
                              ontapp: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await authRepository.signIn(context,
                                      email: email, password: password);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Don't have an Account?",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black87),
                                  ),
                                  Hero(
                                    tag: '1',
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
