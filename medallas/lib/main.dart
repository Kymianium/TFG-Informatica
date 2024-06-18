import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/homepage.dart';
import '/pages/define_medal.dart';
import '/pages/consult_medals.dart';
import '/providers/when_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => WhenModel())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const Homepage(),
      routes: {
        '/homepage': (context) => const Homepage(),
        '/define_medal': (context) => const DefineMedal(),
        '/consult_medals': (context) => const ConsultMedals(),
      },
    );
  }
}
