import 'package:finndata_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../constants/constants.dart';
import '../widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
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
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
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
      }, builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
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
                        const Hero(
                          tag: '1',
                          child: Text(
                            'Sign Up',
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
                              border:
                                  Border.all(color: Colors.blueGrey, width: 2),
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
                          title: 'Register',
                          ontap: () async {
                            _authenticateWithEmailAndPassword(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // If email is valid adding new event [SignUpRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(email, password),
      );
    }
  }
}
