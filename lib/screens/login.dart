import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../constants/constants.dart';
import '../widgets/button.dart';
import 'home.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          }
          if (state is AuthError) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Ops! Login Failed ${state.error.code}'),
                content: Text('${state.error.message}'),
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
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Form(
                key: _formKey,
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
                                'Welcome back!',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 30, right: 20, left: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blueGrey, width: 2),
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
                                          return 'Please enter Email';
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
                                          return 'Please enter Password';
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
                                ontap: () async {
                                  _authenticateWithEmailAndPassword(context);
                                },
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an Account?",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black87),
                                      textAlign: TextAlign.center),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(email, password),
      );
    }
  }
}
