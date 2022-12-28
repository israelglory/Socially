// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socially/models/message_chat.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/screen/chat_screen/chat_screen_viewmodel.dart';
import 'package:socially/theme.dart';
import 'package:socially/widgets/bottom_chat.dart';
import 'package:socially/widgets/chat_app_bar.dart';
import 'package:socially/widgets/receiver_msg.dart';
import 'package:socially/widgets/sender_msg.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.userModel,
    //required this.link,
    //required this.name,
  }) : super(key: key);

  final UserModel userModel;
  //String link;
  //String name;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      viewModelBuilder: () => ChatScreenViewModel(),
      onModelReady: (model) {
        model.initState(userModel.uid);
      },
      builder: (context, model, _) {
        return Scaffold(
          appBar: ChatAppBar(
            link: userModel.avatar,
            name: userModel.fullName,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                /*Expanded(
                  child: _DemoMessageList(),
                ),*/
                Flexible(
                  child: model.groupChatId.isNotEmpty
                      ? StreamBuilder<QuerySnapshot>(
                          stream: model.chatService
                              .getChatStream(model.groupChatId, model.limit),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              model.listMessage = snapshot.data!.docs;
                              if (model.listMessage.length > 0) {
                                return ListView.separated(
                                  padding: const EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    MessageChat messageChat =
                                        MessageChat.fromDocument(snapshot.data
                                            ?.docs[index] as DocumentSnapshot);
                                    final time = Jiffy(messageChat.timestamp)
                                        .format('h:mm a');
                                    return TextMessage(
                                      isUser: messageChat.idFrom ==
                                          model.currentUserId,
                                      message: messageChat.content,
                                      time: time,
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                  reverse: true,
                                  controller: model.listScrollController,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 5,
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    "No message here yet...",
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                BottomChat(
                  onPressed: () {
                    model.onSendMessage(model.textEditingController.text, 0);
                  },
                  txt: model.textEditingController,
                ),
              ],
            ),
          ),
        );
      },
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
          TextMessage(
              isUser: true,
              message: 'Hello this my new widget',
              time: '2:00 PM'),
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

/*AppBar(
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
        title: 
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
      ),*/
