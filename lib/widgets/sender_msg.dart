import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:socially/theme.dart';
import 'package:socially/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SenderMsg extends StatelessWidget {
  const SenderMsg({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message,
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                DateTime.now().toString(),
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  final String time;
  final bool isUser;
  final String message;
  const TextMessage({
    Key? key,
    required this.isUser,
    required this.message,
    required this.time,
  }) : super(key: key);
  static const _borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = (brightness == Brightness.dark);
    return Row(
      mainAxisAlignment:
          isUser == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: isUser == true
                        ? const Radius.circular(_borderRadius)
                        : const Radius.circular(_borderRadius),
                    bottomLeft: isUser == true
                        ? const Radius.circular(_borderRadius)
                        : const Radius.circular(0.0),
                    bottomRight: isUser == true
                        ? const Radius.circular(_borderRadius)
                        : const Radius.circular(_borderRadius),
                    topRight: isUser == true
                        ? const Radius.circular(0.0)
                        : const Radius.circular(_borderRadius)),
                color: isUser
                    ? AppColors.secondary
                    : !isUser && !isDarkMode
                        ? const Color(0xFFF9FAFE)
                        : Theme.of(context).cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Text for the sender
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Container(
                      //color: Colors.yellow,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 144,
                          minWidth: 90),
                      child: ExpandableText(
                        message,
                        onUrlTap: (url) {
                          if ((url).isValidEmail()) {
                            launchUrlString('mailto:$url',
                                mode: LaunchMode.externalApplication);
                          } else {
                            if ((url).contains('http')) {
                              launchUrlString(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              launchUrlString('https:$url',
                                  mode: LaunchMode.externalApplication);
                            }
                          }
                        },
                        style: isDarkMode && isUser == false
                            ? const TextStyle(
                                color: Colors.white,
                              )
                            : !isDarkMode && isUser == false
                                ? const TextStyle(
                                    color: Colors.black,
                                  )
                                : const TextStyle(
                                    color: Colors.white,
                                  ),
                        expandText: 'Read More',
                        maxLines: 4,
                        linkStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                        urlStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          time,
                          style: isDarkMode && isUser == false
                              ? const TextStyle(
                                  color: Colors.white, fontSize: 10)
                              : !isDarkMode && isUser == false
                                  ? const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 10,
                                    )
                                  : TextStyle(
                                      color: Colors.grey.shade200,
                                      fontSize: 10,
                                    ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
