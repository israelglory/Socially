import 'package:socially/exports.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/screen/video_call/video_call_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoPage extends StatelessWidget {
  final String chatId;
  final UserModel userModel;
  const VideoPage({Key? key, required this.chatId, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoPageViewModel>.reactive(
      onModelReady: (model) async {
        await model.userData();
      },
      viewModelBuilder: () => VideoPageViewModel(),
      builder: (context, model, _) {
        return SafeArea(
          top: true,
          child: ZegoUIKitPrebuiltCall(
            appID: model
                .appId, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign: model
                .signId, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: userModel.uid!,
            userName: userModel.userName!,
            callID: chatId,
            // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          ),
        );
      },
    );
  }
}
