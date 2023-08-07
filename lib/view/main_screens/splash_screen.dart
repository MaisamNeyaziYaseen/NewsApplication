import 'package:flutter/material.dart';
import 'package:news_application/view/main_screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    splash();
  }

  Future<void> splash() async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (context, c, s) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xff023B5B),
                  Color(0xff025B8E),
                  Color(0xff76B0D1),
                ]),
          ),
          child: Center(
            child: Text(
              "The Guardian",
              style:
                  TextStyle(fontSize: 32, color: Colors.white.withOpacity(0.5)),
            ),
          )),
    );
  }
}
