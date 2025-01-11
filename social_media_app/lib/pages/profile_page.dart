import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const  IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Profile Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ),

      body: ListView(
        children: [
          const SizedBox(height:50),
          // profile pic
          Icon(
            Icons.person,
            size: 75,
          ),

          const SizedBox(height:10),

          //user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600]
            ),
            ),

            const SizedBox(height:50),

          //user details
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Deatils',
              style: TextStyle(
                color: Colors.grey[850],
              ),
            ),
            )

          //user name 

          //bio


          //user post
        ],
      ),
    );
  }
}