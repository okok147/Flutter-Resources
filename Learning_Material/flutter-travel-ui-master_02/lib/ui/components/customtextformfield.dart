

import 'package:flutter/material.dart';

class CustomTexFormField extends StatelessWidget {

   final String label;
   final IconData icon;

  const CustomTexFormField({Key key, this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      decoration:  InputDecoration(

          labelStyle: TextStyle(color: Color.fromRGBO(211, 211, 211, 1.0), fontSize: 14.0 ),
          hintStyle: TextStyle(color:Color.fromRGBO(211, 211, 211, 1.0), fontSize: 14.0),


          filled: false,
          hasFloatingPlaceholder: false,
          contentPadding: EdgeInsets.all(0.0),
          hintText: label,
          labelText: label,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color:Color.fromRGBO(211, 211, 211, 1.0))
          ),
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 0.0),
            child: Icon(icon, size: 22.0,color: Colors.blue,),
          )),
      keyboardType: TextInputType.text,
    );
  }
}
