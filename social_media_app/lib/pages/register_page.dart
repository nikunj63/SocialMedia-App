import 'package:flutter/material.dart';
import 'package:social_media_app/components/button.dart';
import 'package:social_media_app/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // logo
                Icon(
                  Icons.lock,
                  color: Colors.blueGrey.shade700,
                  size: 100,
                ),
                const SizedBox(height:50),
            
                // welcome back message
                Text(
                  "Lets create an account",
                  style: TextStyle(
                    color: Colors.grey[700]
                  ),
                ),
                const SizedBox(height:25),
                // email text field
                MyTextField(
                  controller: emailTextController, 
                  hintText: "Email", 
                  obscureText: false,
                  ),
                  const SizedBox(height:10),
            
            
                // password textfield
                MyTextField(
                  controller:passwordTextController,
                   hintText: "Password", 
                   obscureText: true,
                   ),
                   const SizedBox(height:10),
            
            
                // confirm password textfield
                MyTextField(
                  controller:confirmPasswordTextController,
                   hintText: "ConfirmPassword", 
                   obscureText: true,
                   ),
            
            const SizedBox(height:10),
                // sign in button
                MyButton(onTap: widget.onTap, 
                text: 'Sign UP'
                ),
            
            const SizedBox(height:25),
                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),
                    ),
                    const SizedBox(height: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}