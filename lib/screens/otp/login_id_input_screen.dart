import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app_auth_func/screens/otp/code_input_screen.dart';
import 'package:flutter_sample_app_auth_func/services/auth/otp.dart';

class LoginIdInputScreen extends StatefulWidget {
  LoginIdInputScreen({super.key});

  @override
  State<LoginIdInputScreen> createState() => _LoginIdInputScreenState();
}

class _LoginIdInputScreenState extends State<LoginIdInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Future<void> _startAuth() async {
    setState(() {
      isLoading = true;
    });

    String loginId = _controller.text;

    final bool flowSucceeded = await startOTP(loginId);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (!flowSucceeded) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CodeInputScreen(loginId: loginId);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Input your email"),
            TextField(
              controller: _controller,
              autofocus: true,
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: _startAuth,
              child: const Text("Next"),
            )
          ],
        ),
      )),
    );
  }
}
