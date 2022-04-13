import 'package:caverna_do_tesouro/app/view/home_page.dart';
import 'package:flutter/material.dart';

import 'view/chat_page.dart';

class MyApp extends StatelessWidget {
  static const home = "/";
  static const chatPage = "/chat";

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caverna do Tesouro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: home,
      routes: {
        home: (context) => const HomePage(),
        chatPage: (context) => const ChatPage(),
      },
    );
  }
}