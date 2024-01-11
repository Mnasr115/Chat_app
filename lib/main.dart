import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/views/auth_cubits/auth_cubit.dart';
import 'package:chat_app/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/views/chat_cubit/chat_cubit.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/signIn_screen.dart';
import 'package:chat_app/views/signUp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned((){
    runApp(const MyApp());
  },
  blocObserver: SimpleBlocObserver(),
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),

        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SignInScreen.id: (context) => SignInScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          ChatScreen.chatId: (context) => ChatScreen(),
        },
        initialRoute: SignInScreen.id,
      ),
    );
  }
}
