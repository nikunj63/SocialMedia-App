import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/drawer.dart';
import 'package:social_media_app/components/text_field.dart';
import 'package:social_media_app/components/wallPost.dart';
import 'package:social_media_app/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // text controller
  final textController =  TextEditingController();
  // signOut user

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  // post message
  void postMessage(){
    // only post if there is something in the textField
    if (textController.text.isNotEmpty) {
      // store in firebase

      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
    // clear the text field
    setState(() {
      textController.clear();
    });
  }

  // navigate to profile page

  void gotToProfilePage(){
    // pop menu drawer
    Navigator.pop(context);

    // got profile page 
    Navigator.push(context, 
    MaterialPageRoute(builder: 
    (context)=> const ProfilePage()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: const  IconThemeData(
          color: Colors.white,
        ),
        title: const Text("The Wall",style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold,
        ),
        ),
        backgroundColor: Colors.grey[900],

      ),

      drawer: MyDrawer(
        onProfileTap: gotToProfilePage,
        onSignOut: signOut,
      ),



      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy(
                  "TimeStamp",
                  descending: false
                )
                .snapshots(), 
                builder: (context,snapshot){
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context , index){
                        // get message
                        final post = snapshot.data!.docs[index];
                        return Wallpost(
                          message: post['Message'], 
                          user: post['UserEmail'],
                          postId: post.id, 
                          likes: List<String>.from(post['Likes'] ?? []),
                          );
                      }
                      );
                  }else if (snapshot.hasError){
                    return Center(
                      child: Text('Error:${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                )
              ),

            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  // text field
                  Expanded(
                    child: MyTextField(
                      controller: textController, 
                      hintText: 'Write something on the Wall...', 
                      obscureText: false,
                      )
                    ),
                    
                    // post button
                    IconButton(
                      onPressed: postMessage, 
                      icon: const Icon(Icons.arrow_circle_up)
                      )
              
                ],
              ),
            ),
        
        
            //put message
        
            // logged in as
            Text("Logged in as: " + currentUser.email!,
            style: TextStyle(color:Colors.grey),
            ),

            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}