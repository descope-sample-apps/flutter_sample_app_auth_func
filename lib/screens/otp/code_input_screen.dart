import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app_auth_func/screens/home_screen.dart';
import 'package:flutter_sample_app_auth_func/services/auth/otp.dart';

class CodeInputScreen extends StatefulWidget {
  final String loginId;
  CodeInputScreen({required this.loginId, super.key});

  @override
  State<CodeInputScreen> createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  Future<void> _verifyCode() async {
    if (_controller.text.isEmpty || _controller.text.length != 6) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    bool flowSucceeded = await verifyOTP(widget.loginId, _controller.text);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
    print(flowSucceeded);

    if (!flowSucceeded) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const HomeScreen();
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
                const Text("Enter verification code"),
                TextField(
                    controller: _controller,
                    autofocus: true,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _verifyCode,
                  child: const Text("Next"),
                )
              ]),
        )));
  }
}
