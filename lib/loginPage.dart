import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "./home.dart";

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final formkey = new GlobalKey<FormState>();

  String _email, _password;
  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        print(user.uid);
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => homepage()));
        });
      } catch (e) {
        print('Error $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Student App"), automaticallyImplyLeading: false),
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 50, right: 50),
        child: Column(
          children: <Widget>[
            Text(
              "Hey, \nLets Begin...",
              style: TextStyle(fontSize: 60, fontStyle: FontStyle.italic),
            ),
            new Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                          ),
                          validator: (value) =>
                              value.isEmpty ? "Email can't be empty" : null,
                          onSaved: (value) => _email = value,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                          ),
                          obscureText: true,
                          validator: (value) =>
                              value.isEmpty ? "Password can't be empty" : null,
                          onSaved: (value) => _password = value,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 50, right: 50),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                            side: BorderSide(color: Colors.redAccent),
                          ),
                          color: Colors.white,
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 40, color: Colors.redAccent)),
                          onPressed: validateAndSubmit,
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
