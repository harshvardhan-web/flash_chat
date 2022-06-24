import 'package:flutter/material.dart';
import 'package:flash_chat/components.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  // late AnimationController controller;
  // late Animation animation;
  //
  // @override
  // void initState(){
  //   super.initState();
  //   controller = AnimationController(
  //     duration: Duration(seconds: 3),
  //     vsync: this,
  //   );
  //
  //   animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  //
  //   animation.addStatusListener((status) {
  //     if(status == AnimationStatus.completed){
  //       controller.reverse(from: 1);
  //     }else if(status == AnimationStatus.dismissed){
  //       controller.forward();
  //     }
  //   });
  //
  //   controller.addListener(() {
  //     setState((){});
  //     print(animation.value);
  //   });
  // }
  //
  // void dispose(){
  //   controller.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Flash Chat',
                          speed: Duration(milliseconds: 100),
                          textStyle: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          )
                      )
                    ],
                  repeatForever: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(title: 'Log In', color: Colors.lightBlueAccent, onPressed: (){
              Navigator.pushNamed(context, 'login_screen');
            }),
            RoundedButton(title: 'Register', color: Colors.blueAccent, onPressed: (){
              Navigator.pushNamed(context, 'registration_screen');
            })
        ])
      )
    );
  }
}