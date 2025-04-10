import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset password"), centerTitle: true),
      body: Center(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Your email",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
