import 'package:ecommerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(errorMessage, style: TextStyle(color: Colors.red)),
                SizedBox(height: 6.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Your email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Your password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    loadDialog();
                    login(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadDialog() {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      await Future.delayed(Durations.long4);
      setState(() {
        errorMessage = "One of the fields is empty";
      });
      if (mounted) Navigator.pop(context);
    } else {
      try {
        await authService.value.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (mounted) Navigator.pop(context);
        _emailController.clear();
        _passwordController.clear();
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message as String;
        });
        if (mounted) Navigator.pop(context);
      }
    }
  }
}
