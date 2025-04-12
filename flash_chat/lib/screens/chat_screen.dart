import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();
  final meassgeController=TextEditingController();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  late String messageText;
  late var currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

  void getCurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      Navigator.pushNamed(context, 'Welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              bool logoutConfirmed = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout Confirmation'),
                  content: Text('Are you sure to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );

              if (logoutConfirmed) {
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                );
              }
            },
            child: Text(
              'LogOut   ',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 15),
            ),
          )
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    decoration: kMessageContainerDecoration,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.collection('messages').orderBy('Timestamp',descending:true).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messages = snapshot.data?.docs.reversed;
                          if (messages != null) {
                            List<Widget> messageWidgets = [];
                            for (var message in messages) {
                              final messageData = message.data();
                              String messageText = 'No message text';
                              String messageSender = 'Unknown sender';

                              if (messageData != null) {
                                if (messageData is Map<String, dynamic>) {
                                  messageText = messageData['Text'] ?? 'No message text';
                                  messageSender = messageData['Sender'] ?? 'Unknown sender';
                                   currentUser=loggedInUser?.email;
                                }
                              }

                              final messageWidget = MessageBubble(
                                Sender: messageSender,
                                Message: messageText,
                                isMe: (currentUser ==messageSender),
                              );
                              messageWidgets.add(messageWidget);
                            }
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: messageWidgets,
                            );
                          } else {
                            return Text('No messages found');
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: meassgeController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        meassgeController.clear();
                        _fireStore.collection('messages').add({
                          'Text': messageText,
                          'Sender': loggedInUser!.email,
                          'Timestamp': FieldValue.serverTimestamp(),
                        }).then((_) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        });
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
        )
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.Sender, required this.Message,required this.isMe});

  String Sender;
  String Message;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max, // add this line
        children: [
          Padding( // add this widget
            padding: isMe?EdgeInsets.only(right: 15.0):EdgeInsets.only(left: 15.0), // adjust the value as needed
            child: Column(
              crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: Sender,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(text: '  '), // add two spaces
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                Material(
                  borderRadius: isMe?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                  elevation: 5.0,
                  color: isMe?Colors.blue[500]:Colors.lightBlueAccent,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      Message,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}