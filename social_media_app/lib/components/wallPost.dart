import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/like_button.dart';

class Wallpost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List <String> likes;
  const Wallpost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,

    });

  @override
  State<Wallpost> createState() => _WallpostState();
}

class _WallpostState extends State<Wallpost> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // Like status
  late bool isLiked;
  @override
  void initState(){
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }
  // toggle like
  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });

    // Acces the Document in firebase
    DocumentReference postRef = 
    FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      // id the post is now liked , add the user email to the liked  field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      // id the post is now unliked , remove the user email to the liked  field
      postRef.update({
        'Likes':FieldValue.arrayRemove([currentUser.email])
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
        ),
      margin: const EdgeInsets.only(top: 25, left: 25 , right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // like button
              LikeButton(
                isLiked: isLiked, 
                onTap:toggleLike,
                ),
                
                const SizedBox(height: 5),

              // like count
              Text(
                widget.likes.length.toString(),
                style: const  TextStyle(color: Colors.grey),
                ),


            ],
          ),
          const SizedBox(width: 20,),
          // message and user email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 10,),
              Text(widget.message),
      
            ],
          )
        ],
      ),
    );
  }
}