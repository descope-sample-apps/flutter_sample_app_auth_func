import 'package:descope/descope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app_auth_func/screens/welcome_screen.dart';
import 'package:flutter_sample_app_auth_func/services/util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  DescopeUser? user = Descope.sessionManager.session?.user;

  Future<void> _logout() async {
    setState(() {
      isLoading = true;
    });

    await logout();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user data available'),
        ),
      );
    }
    DescopeUser userInfo = user!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hi, ${userInfo.name}!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge),
            Text('Email: ${userInfo.email}'),
            Text('Phone: ${userInfo.phone}'),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: isLoading ? null : _logout,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text.rich(
                      TextSpan(
                        text: 'Log out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
