import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_task/core/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      context.goNamed(RouteNames.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_main.png', width: 250, height: 100),
            SizedBox(height: 20),
            Text('TIRLIK', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
    );
  }
}
