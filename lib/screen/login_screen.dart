import 'package:flutter/material.dart';
import 'package:todo/const/colors.dart';
import 'package:todo/data/auth_data.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false; // State variable to manage loading state
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _handleLogin() async {
    setState(() {
      _isLoading = true; // Show loading effect
    });

    try {
      // Simulate login process
      await AuthenticationRemote().login(email.text, password.text);
    } catch (e) {
      // Handle any login errors here
      print(e);
    } finally {
      setState(() {
        _isLoading = false; // Hide loading effect
      });
    }
  }

  Widget Login_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: _isLoading ? null : _handleLogin, // Disable click during loading
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text(
                  'LogIn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Login_bottom(),
      ),
    );
  }
}
