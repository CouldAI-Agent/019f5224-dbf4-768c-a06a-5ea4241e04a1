import 'package:flutter/material.dart';
import 'mpc_screen.dart';

void main() {
  runApp(const BoomBapApp());
}

class BoomBapApp extends StatelessWidget {
  const BoomBapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boom Bap Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2B2B2B),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MpcScreen(),
      },
    );
  }
}
