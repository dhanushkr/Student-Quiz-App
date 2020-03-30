import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './resultinfo.dart';
import './quizpage.dart';
import "package:firebase_auth/firebase_auth.dart";
import "./loginPage.dart";
import "./about.dart";
import "./resultpage.dart";
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  Widget customcard(String langname, String image) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: InkWell(
        onTap: () {
          print(langname);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(langname),
          ));
        },
        child: Material(
          color: Colors.redAccent,
          elevation: 30.0,
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 100.0,
                      width: 100.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    List<String> subject = [];
    user() async {
      var dir =
          new Directory('/Users/dhanush/Documents/Focus/student_app/images');
      dir.list().listen((FileSystemEntity entity) {
        images.add(entity.path);
        subject.add(entity.path.substring(50).split(".")[0]);
      });
      FirebaseUser user = (await FirebaseAuth.instance.currentUser());
      return user.email.toString();
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return FutureBuilder(
        future: user(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(text.data.split("@")[0].toUpperCase()[0]+text.data.split("@")[0].substring(1)),
                    accountEmail: Text(text.data),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        text.data[0].toUpperCase(),
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About", style: TextStyle(fontSize: 20)),
                      onTap: () {
                        List data = [];
                        var file = new File('/Users/dhanush/Documents/Focus/student_app/assets/file.txt');
                        List<String> lines = file.readAsLinesSync();
                        lines.forEach((l) {
                          if (l != null) {
                            var info = l.split(",");
                            if (info[0] ==
                                text.data.split("@")[0].toUpperCase()) {
                              if (info != null) {
                                //print(info);
                                data.add([info[1], info[2]]);
                              }
                            }
                          }
                        });
                        print(data);
                        if(data.length!=0){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => About(data)));}
                      }),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Result", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      List data = [];
                      var file = new File("/Users/dhanush/Documents/Focus/student_app/assets/file.txt");
                      List<String> lines = file.readAsLinesSync();
                      lines.forEach((l) {
                        if (l != null) {
                          var info = l.split(",");
                          if (info[0]==text.data.split("@")[0].toUpperCase()) {
                            if (info != null) {
                              //print(info);
                              data.add([info[1], info[2]]);
                            }
                          }
                        }
                      });
                      print(data.length);
                      if(data.length!=0){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ResultInfo(data: data)));}
                    },
                  ),
                  Divider(),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.highlight),
                      title: Text("Sign Out", style: TextStyle(fontSize: 20)),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        //prefs.remove("email");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                    ),
                    color: Colors.white,
                    elevation: 30,
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                "Student App",
                style: TextStyle(
                  fontFamily: "Quando",
                ),
              ),
            ),
            body: Padding(
                padding: EdgeInsets.only(top: 40),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final item = images[index];
                    return customcard(subject[index], item);
                  },
                )),
          );
        });
  }
}
