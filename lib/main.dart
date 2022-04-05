import 'package:caverna_do_tesouro/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caverna do Tesouro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}
