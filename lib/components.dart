import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {

  RoundedButton({
    required this.title,
    required this.color,
    required this.onPressed
  });

  final Color color;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}


class Credentials extends StatelessWidget {
  Credentials({required this.title, required this.onPressed, required this.hidden});

  final String title;
  final Function(String) onPressed;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onPressed,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.lightBlueAccent,
      ),
      obscureText: hidden,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          color: Colors.lightBlueAccent,
        ),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
