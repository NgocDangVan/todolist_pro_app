import 'dart:ffi';

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final bool isFirstTimeInstallApp;
  const WelcomePage({super.key, required this.isFirstTimeInstallApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: isFirstTimeInstallApp == true
              ? IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined,
                      size: 18, color: Colors.white),
                )
              : null),
      body: Column(
        children: [
          _buildTitleAndDesc(),
          const Spacer(),
          _buildButtonLogin(),
          _buildButtonRegister(),
        ],
      ),
    );
  }

  Widget _buildTitleAndDesc() {
    return Container(
      margin: EdgeInsets.only(top: 58),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Welcome to UpTodo",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontFamily: "Lato",
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 26),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Please login to your account or create new account to continue",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.67),
                  fontFamily: "Lato",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          child: Text(
            "LOGIN",
            style: const TextStyle(
                fontSize: 16, fontFamily: "Lato", color: Colors.white),
          )),
    );
  }

  Widget _buildButtonRegister() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.symmetric(vertical: 28),
      child: ElevatedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: BorderSide(width: 1, color: const Color(0xFF8875FF))),
          child: Text(
            "CREATE ACCOUNT",
            style: const TextStyle(
                fontSize: 16, fontFamily: "Lato", color: Colors.white),
          )),
    );
  }
}
