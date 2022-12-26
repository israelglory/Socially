// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socially/models/user_data.dart';
import 'package:socially/screen/chat_home/chat_home_view_model.dart';
import 'package:socially/widgets/message_item.dart';
import 'package:socially/widgets/story_item.dart';
import 'package:stacked/stacked.dart';

import '../../image_random.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatHomeViewModel>.reactive(
      viewModelBuilder: () => ChatHomeViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Socially'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.square_arrow_up,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          hintText: 'Search',
                          fillColor: Colors.lightBlue[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          //contentPadding: EdgeInsets.all(20),
                          hintStyle:
                              TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                /*SliverToBoxAdapter(
                  child: Stories(),
                ),*/
                SliverList(
                  delegate: SliverChildBuilderDelegate(_delegate),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _delegate(BuildContext context, int index) {
  final Faker faker = Faker();
  final date = Helpers.randomDate();

  var human = faker.person.name();
  var pic = Helpers.randomPictureUrl();

  return MessageItem(
    messageData: MessageData(
      senderName: human,
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: Jiffy(date).fromNow(),
      profilePicture: pic,
    ),
  );
}

class Stories extends StatelessWidget {
  const Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    'Your Story',
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StoryItem(
                      link: Helpers.randomPictureUrl(),
                      name: faker.person.lastName(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
