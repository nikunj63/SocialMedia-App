import 'package:flutter/material.dart';

class Wallpost extends StatelessWidget {
  final String message;
  final String user;
  const Wallpost({
    super.key,
    required this.message,
    required this.user,

    });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(user),
            Text(message),

          ],
        )
      ],
    );
  }
}