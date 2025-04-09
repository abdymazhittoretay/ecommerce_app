import 'package:ecommerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteUserPage extends StatefulWidget {
  const DeleteUserPage({super.key});

  @override
  State<DeleteUserPage> createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete user"), centerTitle: true),
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
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Your email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                obscureText: true,
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
                  deleteUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                child: Text("Delete account"),
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

  Future<void> deleteUser({
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await authService.value.deleteUser(email: email, password: password);
        _emailController.clear();
        _passwordController.clear();
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
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
