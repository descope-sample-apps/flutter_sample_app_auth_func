import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app_auth_func/screens/otp/code_input_screen.dart';
import 'package:flutter_sample_app_auth_func/services/auth/otp.dart';

class LoginIdInputScreen extends StatefulWidget {
  const LoginIdInputScreen({super.key});

  @override
  State<LoginIdInputScreen> createState() => _LoginIdInputScreenState();
}

class _LoginIdInputScreenState extends State<LoginIdInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Future<void> _startAuth() async {
    if (!isEmailValid(_controller.text)) {
      return;
    }
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

  bool isEmailValid(String? text) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return text!.isNotEmpty && regex.hasMatch(text);
  }

  String? validateEmail(String? value) {
    bool isValid = isEmailValid(value);

    return isValid ? null : 'Enter a valid email address';
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
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                validator: validateEmail,
                controller: _controller,
                autofocus: true,
              ),
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
