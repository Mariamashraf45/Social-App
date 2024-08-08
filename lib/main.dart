
import 'package:fire/global/app_them.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Screen',
      theme: appTheme,
      home:Text('Flutter New Feature') ,
    );
  }
}
