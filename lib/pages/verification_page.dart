import 'dart:async';

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
  late Timer timer;

  @override
  void initState() {
    super.initState();
    isVerified = authService.value.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerification();

      timer = Timer.periodic(Durations.medium2, (_) => checkVerification());
    }
  }

  Future<void> checkVerification() async {
    await authService.value.currentUser!.reload();

    setState(() {
      isVerified = authService.value.currentUser!.emailVerified;
    });

    if (isVerified) timer.cancel();
  }

  Future<void> sendVerification() async {
    try {
      await authService.value.currentUser!.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
              children: [
                Text("Verification message was sent to your email"),
                SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Resend verification message"),
                ),
                SizedBox(height: 6.0),
                ElevatedButton(
                  onPressed: () async {
                    await authService.value.signOut();
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ),
        );
  }
}
