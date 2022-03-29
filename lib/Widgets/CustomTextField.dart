import 'package:flutter/material.dart';
class CustomTextoField extends StatelessWidget {
  String? hint;
  Function? onchange;
  bool? isPass ;

  CustomTextoField({this.hint,this.onchange,this.isPass});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'Please Enter Data';
        }
      },
      onChanged: (data){
        onchange!(data);

      },
      obscureText: isPass!,

      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          )
      ),
    );
  }
}
