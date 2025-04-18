import 'package:ecommerce_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUsernamePage extends StatefulWidget {
  const UpdateUsernamePage({super.key});

  @override
  State<UpdateUsernamePage> createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final TextEditingController _controller = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update username"), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 6.0),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "New username",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  loadDialog();
                  updateUsername(newUsername: _controller.text);
                },
                child: Text("Update"),
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

  Future<void> updateUsername({required String newUsername}) async {
    if (newUsername.isNotEmpty) {
      try {
        await authService.value.updateUsername(newUsername: newUsername);
        _controller.clear();
        if (mounted) Navigator.pop(context);
        if (mounted) Navigator.pop(context, true);
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message as String;
        });
      }
    } else {
      await Future.delayed(Durations.long4);
      setState(() {
        errorMessage = "Field is empty";
      });
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
