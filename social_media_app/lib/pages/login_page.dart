import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/button.dart';
import 'package:social_media_app/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

 // sign User In
 void signIn()async {
  try{await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailTextController.text, 
    password: passwordTextController.text,
    );
    }on FirebaseAuthException catch(e){
      print(e.code);
    }
 }
 // display a dialog message
 void displayMessage(String message){
  showDialog(
    context: context, 
    builder: (context)=>AlertDialog(
      
    )
    );
 }

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
                  "Welcome back you've been missed!",
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
                // sign in button
                MyButton(onTap: signIn, 
                text: 'Sign In'
                ),
            
            const SizedBox(height:25),
                // go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),
                    ),
                    const SizedBox(height: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Register now",
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