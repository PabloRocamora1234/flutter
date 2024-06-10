import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Primera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRIMERA PANTALLA"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("IR A SEGUNDA"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Segunda()),
            );
          },
        ),
      ),
    );
  }
  
  RaisedButton({required Text child, required Null Function() onPressed}) {}
}

class Segunda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SEGUNDA PANTALLA"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("ATRÁS"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  
  RaisedButton({required Text child, required Null Function() onPressed}) {}
}
