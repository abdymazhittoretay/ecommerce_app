import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }
}
