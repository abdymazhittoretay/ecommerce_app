import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/welcome_page.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, service, child) {
        return StreamBuilder(
          stream: service.authStateChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return WelcomePage();
            }
          },
        );
      },
    );
  }
}
