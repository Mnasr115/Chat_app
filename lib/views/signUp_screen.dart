import 'package:chat_app/components/constant/constant.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/signIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/components.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key,});
  static String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email,password;

  bool isLoading = false;
final  _formKey = GlobalKey<FormState> ();


  @override
  Widget build(BuildContext context) {
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
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await signUpUser();
                         Navigator.pushNamed(context, ChatScreen.chatId);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'weak password');
                          } else if (e.code == 'e-mail already in use') {
                            showSnackBar(context, 'email already exist');
                          }
                        }
                        catch (e) {
                          print(e);
                          showSnackBar(context, 'there was an error');
                        }
                       setState(() {
                         isLoading = false;
                       });

                      }
                      else {}
                      Navigator.pop(context);
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
  }

    Future<void> signUpUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
