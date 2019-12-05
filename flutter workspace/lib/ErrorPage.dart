import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jojobusdriver/util/Global.dart';



class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
    void initState() {
      // TODO: implement initState
      Timer( Duration( milliseconds: 1000),(){
        while( Navigator.canPop(context)){
                      Navigator.pop(context);                    
                    }
        Global.router.navigateTo(context, "/",
            transition: TransitionType.fadeIn, replace: true);
      });
      

      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    var ww = MediaQuery.of(context).size.width;
    var hh = MediaQuery.of(context).size.height;
    return  Scaffold(             
       body: Container(
          decoration:  BoxDecoration(
             image:  DecorationImage(
                image: AssetImage("images/login.png"),
                 fit: BoxFit.cover                          
          ),  
          ),
                child: Center(
            child: CircularProgressIndicator(
               valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
         ),
       ),
      
    );
  }
}