import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app_auth_func/screens/home_screen.dart';
import 'package:flutter_sample_app_auth_func/screens/otp/login_id_input_screen.dart';
import 'package:flutter_sample_app_auth_func/services/auth/oauth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = false;

  Future<void> _startAuth() async {
    setState(() {
      isLoading = true;
    });

    final bool flowSucceeded = await startOAuth();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (!flowSucceeded) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Descope\'s Flutter Sample App!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: isLoading ? null : _startAuth,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login via Google'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginIdInputScreen(),
                  ));
                },
                child: const Text("Login via OTP"))
          ],
        ),
      ),
    );
  }
}
