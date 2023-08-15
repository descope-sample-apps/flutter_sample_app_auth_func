import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:descope/descope.dart';
import 'package:flutter_sample_app_auth_func/screens/home_screen.dart';
import 'package:flutter_sample_app_auth_func/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final String? projectId = dotenv.env["DESCOPE_PROJECT_ID"];

  if (projectId == null || projectId.isEmpty) {
    throw Exception("DESCOPE_PROJECT_ID is not set");
  }

  Descope.projectId = projectId;

  Descope.sessionManager.loadSession();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descope Flutter Sample App (Authentication Functions)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Descope.sessionManager.session?.refreshToken.isExpired == false
          ? const HomeScreen()
          : const WelcomeScreen(),
    );
  }
}
