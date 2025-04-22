import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // all users
  final userCollection = FirebaseFirestore.instance.collection('Users');

  // edit field
  Future<void>editField(String field)async{
    String? newValue = await showDialog(
  context: context,
  builder: (context) {
    String tempValue = ""; // local to the dialog

    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        'Edit $field',
        style: const TextStyle(color: Colors.white),
      ),
      content: TextField(
        autofocus: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Enter new $field",
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        onChanged: (value) {
          tempValue = value;
        },
      ),
        actions: [
          // cancel button
          TextButton(
            onPressed: ()=> Navigator.pop(context), 
            child: const Text('Cancel' , 
            style:TextStyle(
              color: Colors.white
            )
            )),


          // save button
          TextButton(
            onPressed: ()=> Navigator.pop(context, tempValue), 
            child: const Text('Save' , 
            style:TextStyle(
              color: Colors.white
            )
            )),
        ],
      );
  } 
    );

      // updating values in firestore
      if (newValue != null) {
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userEmail)
      .update({ field: newValue }) //  dynamic field update
      .then((_) => print("Field '$field' updated to: $newValue"))
      .catchError((error) => print("Error updating field: $error"));
}

  }

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

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users')
        .doc(currentUser.email).snapshots(), 
        builder: (context , snapshot){
          // get User Data
          if(snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String , dynamic>;

            return ListView(
        children: [
          const SizedBox(height:50),
          // profile pic
         const Icon(
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
            ),

          //user name 
          MyTextBox(
            text: 'username', 
            sectionName: userData['username'],
            onPressed: ()=> editField('username'),
            ),

          //bio

          MyTextBox(
            text: 'bio', 
            sectionName: userData['bio'],
            onPressed: ()=> editField('bio'),
            ),

            const SizedBox(height:50),

          //user post

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'My Posts',
              style: TextStyle(
                color: Colors.grey[850],
              ),
            ),
            ),
        ],
      );
          }else if(snapshot.hasError){
            return Center(
              child: Text('Error' + snapshot.error.toString()),
            );
          }
          return const CircularProgressIndicator();
        }
        )
    );
  }
}