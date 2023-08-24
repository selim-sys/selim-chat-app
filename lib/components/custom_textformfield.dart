import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({
     required this.hint,
     required this.label,
     required this.onChanged,
     required this.valid,
     required this.isOb
});
   String hint,label,valid;
   Function(String)? onChanged;
   bool isOb = false;

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      obscureText: isOb,
      validator: (value) {
        if(value!.isEmpty){
         return valid;
        }

      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(

          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          label: Text(label,
            style: TextStyle(color: Colors.white),),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                  color: Colors.white)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                  width: 3,
                  color: Colors.white)
          )
      ),
    );
  }
}
