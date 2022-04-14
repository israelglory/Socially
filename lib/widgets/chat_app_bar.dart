import 'package:flutter/material.dart';
import 'package:socially/models/user_data.dart';
import 'package:socially/theme.dart';
import 'package:socially/widgets/avatar.dart';

class ChatAppBar extends StatelessWidget {
  ChatAppBar({
    Key? key,
    //required this.messageData,
    required this.link,
    required this.name,
  }) : super(key: key);

  // final MessageData messageData;
  String link;
  String name;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = (brightness == Brightness.dark);
    return Row(
      children: [
        Avatar.medium(
          url: link,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 3),
              const Text(
                'Online now',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}