import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

late User loggedInUser;
late String messageText;

class _ChatScreenState extends State<ChatScreen> {

  final messageTextController = TextEditingController();

  final auth = FirebaseAuth.instance;


  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    final user = await auth.currentUser;
    if(user!= null){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }

  //Not viable because it is static i.e get data only upon calling
  // void getMessages() async{
  //   final messages = await FirebaseFirestore.instance.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  //this works better because it acts as a listener for new messages and returns any new piece of info as soon as it is inserted.
  void messagesStream() async{
    await for(var snapshot in  FirebaseFirestore.instance.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      FirebaseFirestore.instance.collection('messages').add(
                          {
                            'text': messageText,
                            'sender': loggedInUser.email,
                          }
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.text, required this.isMe});

  final sender;
  final text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white70
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(isMe? 20.0: 0.0),
              topRight: Radius.circular(isMe? 0.0 : 20.0),
            ),
            color: isMe? Colors.lightBlueAccent: Colors.teal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                "$text",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for(var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];

            final currentUser = loggedInUser.email;

            if(currentUser == messageSender){

            }

            final messageBuble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser==messageSender,
            );

            messageBubbles.add(messageBuble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbles,
            ),
          );
        }
    );
  }
}



