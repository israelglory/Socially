import 'package:socially/models/user_model.dart';
import 'package:socially/services/user_service/user_auth.dart';
import 'package:stacked/stacked.dart';

class VideoPageViewModel extends BaseViewModel {
  UserModel user = UserModel();
  final String signId =
      '977574af596a4ad9d5b9e3ca2d2157fee7d1f90c53c4f30fb8014584b4487afd';
  final int appId = 1961332168;
  Future<void> userData() async {
    final userinfo = await UserAuth().getUserData();

    user = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      uid: userinfo['uid'],
      userName: userinfo['userName'],
    );
    notifyListeners();
  }
}
