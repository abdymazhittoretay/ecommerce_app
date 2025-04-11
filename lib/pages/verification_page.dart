import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late bool isVerified;

  @override
  void initState() {
    super.initState();
    isVerified = authService.value.currentUser!.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return isVerified
        ? HomePage()
        : Scaffold(
          appBar: AppBar(title: Text("Verification Page"), centerTitle: true),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Verification message was sent to your email")],
            ),
          ),
        );
  }
}
