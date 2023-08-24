import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class chatBubble extends StatelessWidget {
  chatBubble({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(vertical: 4),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 16),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class chatBubbleForAnotherUser extends StatelessWidget {
  chatBubbleForAnotherUser({
    super.key,
    required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsetsDirectional.symmetric(vertical: 4),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 16),
        decoration: BoxDecoration(
            color: Color(0xff006488),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32))),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
