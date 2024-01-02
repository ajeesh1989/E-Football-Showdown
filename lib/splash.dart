import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_pre_hive_sampleproject/loby.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_pre_hive_sampleproject/group_home.dart';
import 'package:shared_pre_hive_sampleproject/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedName = sharedPrefs.getString('add_name');
    final savedPassword = sharedPrefs.getString('add_password');

    Future.delayed(const Duration(seconds: 3), () {
      if (savedName != null && savedPassword != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LobbyPage(loginName: savedName)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/pics/HD-wallpaper-footballs-5-goats-five-football.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Column(
                children: [
                  TyperAnimatedTextKit(
                    isRepeatingAnimation: false,
                    text: ['E-Football Showdown'],
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100), // Adjust speed
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
