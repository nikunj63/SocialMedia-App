import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // text controller
  final textController =  TextEditingController;
  // signOut user

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("The Wall",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
        actions: [
          // sign out button
          IconButton(
            onPressed:signOut , 
            icon:const  Icon(Icons.logout),
            )
        ],

      ),
      body: Center(
        child: Column(
          children: [
            // the wall
        
        
            //put message
        
            // logged in as
            Text("Logged in as: " + currentUser.email!),
          ],
        ),
      ),
    );
  }
}