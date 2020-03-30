import 'dart:io';
import "./home.dart";
import "package:flutter/material.dart";

class ResultInfo extends StatelessWidget {
  List data;
  ResultInfo({this.data});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Student App"),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.home),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => homepage()));
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Card(elevation:40,
                          child: new Container(
                            width:300,
                            color:Colors.white,
                          padding: new EdgeInsets.all(70.0),
                            child: new Column(
                            children: <Widget>[
                            new Text(data[index][0],style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold)),
                            Padding(padding:EdgeInsets.only(top:10)),
                              new Text("Score : "+data[index][1],style:TextStyle(fontSize: 20,fontStyle:FontStyle.italic))
                            ],
                            ),))
                      ],
                    ));
                  }));
        });
  }
}
