// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:socially/widgets/avatar.dart';

class StoryItem extends StatelessWidget {
  StoryItem({
    Key? key,required this.link, required this.name,
  }) : super(key: key);

  String link;
  String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          child:Avatar.large(url: link),),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}