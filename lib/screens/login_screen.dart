import 'package:flutter/material.dart';
import 'package:flash_chat/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  var email, pass;
  bool showSpinner = false;

  @override
  void initState(){
    super.initState();
    FirebaseInitialize();
  }

  void FirebaseInitialize()async{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

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
              },),
              SizedBox(
                height: 8.0,
              ),
              Credentials(title: 'Enter your Password', hidden: true, onPressed: (value){
                pass = value;
              },),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Log In', color: Colors.lightBlueAccent, onPressed: ()async{
                setState((){
                  showSpinner = true;
                });
                final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                try{
                  if(user!=null){
                    print(user.user);
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
