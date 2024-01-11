import 'package:chat_app/components/constant/constant.dart';
import 'package:chat_app/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/signIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/components.dart';

class SignUpScreen extends StatelessWidget {
  String? email, password;
  static String id = 'SignUpScreen';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoaded) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, SignInScreen.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            //  fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      onChanged: (data) {
                        email = data;
                      },
                      text: 'Enter your e-mail',
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      obSecureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      text: 'Enter your password',
                      icon: Icons.password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      textButton: 'Sign Up',
                      onPressed: () async {
                        {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(RegisterEvent(email: email!, password: password!));
                          } else {}
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
