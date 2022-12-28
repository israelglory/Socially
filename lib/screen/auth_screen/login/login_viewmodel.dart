import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socially/exports.dart';
import 'package:socially/screen/chat_home/chat_home_view.dart';
import 'package:socially/services/user_service/user_auth.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final UserAuth userAuth = UserAuth();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool inProgress = false;
  bool show = true;

  ///This is to hide the password
  void onObscure() {
    show = false;
    notifyListeners();
  }

  ///We use this function to show password
  onhide() {
    show = true;
    notifyListeners();
  }

  void login(BuildContext context) async {
    try {
      if (emailController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Email Cannot be empty', backgroundColor: Colors.red);
      } else if (passController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Password Cannot be empty', backgroundColor: Colors.red);
      } else {
        inProgress = true;
        notifyListeners();
        await userAuth.loginWithEmailAndPass(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const ChatHomeScreen();
          }),
        );
        inProgress = false;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      inProgress = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: e.message!,
        backgroundColor: Colors.red,
      );
    }
  }
}
