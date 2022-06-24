import 'package:flutter/material.dart';
import 'package:flash_chat/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  var email, pass;

  void FirebaseInitialize()async{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  void initState(){
    super.initState();
    FirebaseInitialize();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Credentials(title: 'Enter your Email', hidden: false, onPressed: (value){
                email = value;
              }),
              SizedBox(
                height: 8.0,
              ),
              Credentials(title: 'Enter your password', hidden: true,onPressed: (value){
                if(value.length<8){
                  return 'Password must be atleast 8 characters long';
                }else{
                  pass = value;
                }
              }),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Register', color: Colors.blueAccent, onPressed: ()async{
                setState((){
                  showSpinner = true;
                });
                try{
                  final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
                  if(newUser!=null){
                    Navigator.pushNamed(context, 'chat_screen');
                  }
                  setState((){
                    showSpinner = false;
                  });
                }catch(e){
                  print(e);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}