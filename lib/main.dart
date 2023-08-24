import 'package:chat_app/screens/chat-screen.dart';
import 'package:chat_app/screens/login-screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginScreen' : (context) => LoginScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginScreen',
    );
  }
}
