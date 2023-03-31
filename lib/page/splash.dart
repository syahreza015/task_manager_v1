import 'package:flutter/material.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // Simulates some background work that takes three seconds.
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to the home page after showing the splash screen for three seconds.
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: const Center(
        child: Icon(
          Icons.book,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
