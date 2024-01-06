
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/signIn_screen.dart';
import 'package:chat_app/views/signUp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignInScreen.id: (context) =>  SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ChatScreen.chatId : (context) =>  ChatScreen(),
      },
      initialRoute: SignInScreen.id,
    );
  }
}
