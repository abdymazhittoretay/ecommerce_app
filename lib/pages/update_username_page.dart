import 'package:flutter/material.dart';

class UpdateUsernamePage extends StatefulWidget {
  const UpdateUsernamePage({super.key});

  @override
  State<UpdateUsernamePage> createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Username"), centerTitle: true),
      body: Center(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "New username",
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
