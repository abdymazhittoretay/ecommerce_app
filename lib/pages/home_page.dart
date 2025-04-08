import 'package:ecommerce_app/pages/update_username_page.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username = AuthService().currentUser!.displayName;
  String? email = AuthService().currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await authService.value.signOut();
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Icon(Icons.person, size: 100.0),
              Text(
                (username == null || username!.isEmpty)
                    ? "You didn't specify username"
                    : username!,
              ),
              SizedBox(height: 8.0),
              Text(email!),
              Spacer(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Update username"),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUsernamePage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Change password"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Delete user"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
