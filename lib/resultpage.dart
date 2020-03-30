import 'dart:io';

import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import './home.dart';

class resultpage extends StatefulWidget {
  int marks;
  String langname;
  resultpage({Key key , @required this.marks,@required this.langname}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks,langname);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "result_image/result.jpg",
  ];

  String message;
  String image;

  @override
  void initState(){
    if(marks < 5){
      image = images[0];
      message = "You Should Try Hard..\n" + "You Scored $langname : $marks";
    }else if(marks < 7){
      image = images[0];
      message = "You Can Do Better..\n" + "You Scored $langname : $marks";
    }else{
      image = images[0];
      message = "You Did Very Well..\n" + "You Scored $langname : $marks";
    }
    super.initState();
  }

  int marks;
  String langname;
  _resultpageState(this.marks,this.langname);
  @override
  Widget build(BuildContext context) {
    user() async {
    FirebaseUser user= (await FirebaseAuth.instance.currentUser());
     return user.email.toString();
  }
    return FutureBuilder(future: user(),
      initialData: "Loading text..",builder:(BuildContext context,AsyncSnapshot<String> text){return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.home),
              onPressed: (){
                var file = new File('/Users/dhanush/Documents/Focus/student_app/assets/file.txt');
                  var sink = file.openWrite(mode:FileMode.append);
                  String name=text.data.split("@")[0].toUpperCase();
                  sink.writeln('$name,$langname,$marks\n');
                  sink.close();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
              }
              ),
        ],
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Quando",
                        ),
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ),            
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                  var file = new File('/Users/dhanush/Documents/Focus/student_app/assets/file.txt');
                  var sink = file.openWrite(mode:FileMode.append);
                  String name=text.data.split("@")[0].toUpperCase();
                  sink.write('$name,$langname,$marks\n');
                  sink.close();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );});
  }
}