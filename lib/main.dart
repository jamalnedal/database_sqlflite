import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vp9_database/database/db_controller.dart';
import 'package:vp9_database/provider/contact_provider.dart';
import 'package:vp9_database/screens/create_contact_screen.dart';
import 'package:vp9_database/screens/launch_screen.dart';
import 'package:vp9_database/screens/login_screen.dart';
import 'package:vp9_database/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/main_screen': (context) => MainScreen(),
        '/create_contact_screen': (context) => CreateContactScreen(),
      },
    );
  }
}
