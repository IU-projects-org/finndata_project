import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../component/button.dart';
import '../constants/constants.dart';
import 'Home_Screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                            const Hero(
                              tag: '1',
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
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
                              title: 'Register',
                              ontapp: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.blueGrey,
                                        content: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Successfully Register!'),
                                        ),
                                        duration: Duration(seconds: 5),
                                      ),
                                    );

                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (routeContext) =>
                                          const HomeScreen(),
                                      ),
                                    );

                                    setState(() {
                                      isLoading = false;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text(
                                            'Ops! Registration Failed'),
                                        content: Text('${e.message}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('Okay'),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
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
