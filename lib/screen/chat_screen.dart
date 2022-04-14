// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/user_data.dart';
import 'package:socially/theme.dart';
import 'package:socially/widgets/bottom_chat.dart';
import 'package:socially/widgets/chat_app_bar.dart';
import 'package:socially/widgets/receiver_msg.dart';
import 'package:socially/widgets/sender_msg.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    Key? key,
    required this.messageData,
     //required this.link,
    //required this.name,
  }) : super(key: key);

  final MessageData messageData;
  //String link;
  //String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: ChatAppBar(
          link: messageData.profilePicture,
          name: messageData.senderName,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconButton(
                icon: const Icon(CupertinoIcons.video_camera_solid),
                onPressed: () {},
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconButton(
                icon: const Icon(CupertinoIcons.phone_solid),
                onPressed: () {},
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: _DemoMessageList(),
          ),
          BottomChat(),
        ],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: const [
          _DateLable(lable: 'Yesterday'),
          ReceivedMsg(
            message: 'Hi, Lucy! How\'s your day going?',
          ),
          SenderMsg(
            message: 'You know how it goes...',
            
          ),
          ReceivedMsg(
            message: 'Do you want Starbucks?',
            
          ),
          SenderMsg(
            message: 'Would be awesome!',
          ),
          ReceivedMsg(
            message: 'Coming up!',
          ),
          SenderMsg(
            message: 'YAY!!!',
          ),
        ],
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
