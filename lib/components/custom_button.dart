import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({required this.text, required this.onTap});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 40,
        child: Center(child: Text(text,style: TextStyle(
            color: Color(0xff274460),
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),)),
      ),
    );
  }
}
