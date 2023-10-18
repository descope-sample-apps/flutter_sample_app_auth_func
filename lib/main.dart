import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:descope/descope.dart';
import 'package:flutter_sample_app_auth_func/screens/home_screen.dart';
import 'package:flutter_sample_app_auth_func/screens/welcome_screen.dart';
import 'package:flutter_sample_app_auth_func/services/auth/magic_link.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final String? projectId = dotenv.env["DESCOPE_PROJECT_ID"];

  if (projectId == null || projectId.isEmpty) {
    throw Exception("DESCOPE_PROJECT_ID is not set");
  }

  Descope.projectId = projectId;

  Descope.sessionManager.loadSession();
  print(Descope.sessionManager.session?.refreshToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router,);
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => Descope.sessionManager.session?.refreshToken.isExpired == false
          ? const HomeScreen()
          : const WelcomeScreen(),
      routes: [
        GoRoute(
          path: 'auth',
          redirect: (context, state) {
            try {
              Descope.flow.exchange(state.uri);
            } catch (e) {
              // Handle errors here
            }
            return '/';
          },
        ),
        // Adding the magic link handling here:
        GoRoute(
          path: 'magiclink', // This path needs to correspond to the deep link you configured in your manifest or associated domain - see below
          redirect: (context, state) async {
            try {
              // Get token from uri
              final token = state.uri.queryParameters['t'];
              await verifyMagicLink(token!);
            } catch (e) {
              // Handle errors here
            }
            return '/'; // This route doesn't display anything but returns the root path where the user will be signed in
          },
        ),
        GoRoute(
           path: 'details',
           builder: (_, __) => Scaffold(
             appBar: AppBar(title: const Text('Details Screen')),
           ),
         ),
      ],
    ),
  ],
);