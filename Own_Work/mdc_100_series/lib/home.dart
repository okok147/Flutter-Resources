// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:Shrine/login.dart';
class HomePage extends StatelessWidget {
  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: Text('SHRRINNEEE'),
      ),
        body: Center(child:
        ListView(





          children: <Widget>[


            SizedBox(height: 280.0),
            Column(


              children: <Widget>[





                //An image of Shrine's logo





                //The name of the app(Shrine)
                Text('You Did it!',),
                SizedBox(height: 16.0),
                new RaisedButton(
                    child: new Text('Logout'),

                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> LoginPage()));
                      
                    }),


              ],
            ),



            //Two text fields,one for entering a username and the other for a password



            SizedBox(height: 16.0),






            //Two buttons

          ],
        ),
        ));
  }
}
