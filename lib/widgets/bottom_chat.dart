// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomChat extends StatelessWidget {
  final Function() onPressed;
  final TextEditingController txt;
  const BottomChat({Key? key, required this.onPressed, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: txt,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 24.0,
              ),
              child: Icon(
                Icons.send_rounded,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
