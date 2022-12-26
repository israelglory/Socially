import 'package:flutter/material.dart';
import 'package:socially/screen/chat_screen/chat_screen_viewmodel.dart';
import 'package:socially/widgets/app_text.dart';

import 'package:socially/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    //required this.messageData,
    required this.link,
    required this.name,
  }) : super(key: key);

  // final MessageData messageData;
  final String link;
  final String name;

  @override
  Widget build(BuildContext context) {
    //var brightness = MediaQuery.of(context).platformBrightness;
    //bool isDarkMode = (brightness == Brightness.dark);
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      //minimum: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, //New
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        height: 56,
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomDMAppBar extends ViewModelWidget<ChatScreenViewModel>
    with PreferredSizeWidget {
  final String link;
  const CustomDMAppBar({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    ChatScreenViewModel viewModel,
  ) {
    return SafeArea(
      top: true,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, //New
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        height: 56,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DmUserProfileView();
                            },
                          ),
                        );*/
                      },
                      child: Row(
                        children: [
                          Avatar.medium(
                            url: link,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                AppText(
                                  'No name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  //color: AppColors.groupmembertxt,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuButton(
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(0.0),
              onSelected: (result) {
                if (result == 0) {
                  //viewModel.onViewProfileTap(chat);
                } else if (result == 1) {
                  //viewModel.onBlockUserTap();
                } else if (result == 2) {
                  //viewModel.onClearChatTap();
                }
              },
              itemBuilder: (BuildContext bc) {
                return [
                  const PopupMenuItem(
                    child: Text("View profile"),
                    value: 0,
                  ),
                  const PopupMenuItem(
                    child: Text("Block"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text("Clear Chat"),
                    value: 2,
                  ),
                ];
              },
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
