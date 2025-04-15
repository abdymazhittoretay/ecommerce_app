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
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;
  Timer? resendTimer;

  @override
  void initState() {
    super.initState();
    final user = authService.value.currentUser;

    if (user != null) {
      isVerified = user.emailVerified;

      if (!isVerified) {
        sendVerification();
        timer = Timer.periodic(
          const Duration(seconds: 3),
          (_) => checkVerification(),
        );
      }
    }
  }

  Future<void> checkVerification() async {
    final user = authService.value.currentUser;
    if (user == null) return;

    try {
      await user.reload();
      final refreshedUser = authService.value.currentUser;

      if (!mounted) return;

      setState(() {
        isVerified = refreshedUser?.emailVerified ?? false;
      });

      if (isVerified) timer?.cancel();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendVerification() async {
    final user = authService.value.currentUser;
    if (user == null) return;

    try {
      await user.sendEmailVerification();
      setState(() => canResend = false);

      resendTimer = Timer(const Duration(seconds: 60), () {
        if (!mounted) return;
        setState(() => canResend = true);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = authService.value.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (isVerified) return const HomePage();

    return Scaffold(
      appBar: AppBar(title: const Text("Verification Page"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Verification message was sent to your email."),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: canResend ? sendVerification : null,
              child: const Text("Resend verification message"),
            ),
            const SizedBox(height: 6.0),
            ElevatedButton(
              onPressed: () async {
                await authService.value.signOut();
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
