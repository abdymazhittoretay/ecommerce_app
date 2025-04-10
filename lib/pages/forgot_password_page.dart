import 'package:ecommerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _controller = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset password"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(errorMessage, style: TextStyle(color: Colors.red)),
              SizedBox(height: 6.0),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Your email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  loadDialog();
                  resetPassword(email: _controller.text);
                },
                child: Text("Reset password"),
              ),
            ],
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

  Future<void> resetPassword({required String email}) async {
    if (email.isNotEmpty) {
      try {
        await authService.value.resetPassword(email: email);
        if (errorMessage != "") {
          setState(() {
            errorMessage = "";
          });
        }
        if (mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message as String;
        });
        if (mounted) Navigator.pop(context);
      }
    } else {
      await Future.delayed(Durations.long4);
      setState(() {
        errorMessage = "One of the fields is empty";
      });
      if (mounted) Navigator.pop(context);
    }
  }
}
