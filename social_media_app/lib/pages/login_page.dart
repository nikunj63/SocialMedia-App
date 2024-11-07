import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              // logo
              Icon(
                Icons.lock,
                color: Colors.blueGrey.shade700,
                size: 100,
              ),
              const SizedBox(height:50),
          
              // welcome back message
              const Text(
                "Welcome back you've been missed!"
              ),
              const SizedBox(height:25)
          
          
              // password textfield
          
          
              // sign in button
          
          
              // go to register page
            ],
          ),
        ),
      ) ,
    );
  }
}