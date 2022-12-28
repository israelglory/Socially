import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/exports.dart';
import 'package:socially/screen/chat_home/chat_home_view.dart';
import 'package:socially/services/user_service/user_auth.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {
  final UserAuth userAuth = UserAuth();
  TextEditingController fullNameController = TextEditingController();
  //TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  //TextEditingController confirmPassController = TextEditingController();
  File? pickedImage;
  final _picker = ImagePicker();
  final _fireStorage = FirebaseStorage.instance;
  bool show = true;
  bool inProgress = false;
  bool terms = false;
  String? uploadUrl;

  ///This is to hide the password
  void onObscure() {
    show = false;
    notifyListeners();
  }

  void onTermAccept(bool newval) {
    terms = newval;
    notifyListeners();
  }

  ///We use this function to show password
  onhide() {
    show = true;
    notifyListeners();
  }

  Future<void> pickImage() async {
    XFile? image;
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      notifyListeners();
      print(pickedImage);
    }
  }

  ///Upload the image picked to firebase storage and assign uploadUrl to the uploaded picture(we are getting a string which is in form of link)
  Future<void> uploadImage() async {
    if (pickedImage != null) {
      final ref = _fireStorage
          .ref('userProfileImage')
          .child(FirebaseAuth.instance.currentUser!.uid);
      try {
        await ref.putFile(pickedImage!);
        uploadUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'avatar': uploadUrl,
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Unable to upload Image',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  ///Signingup with fullname and email and password
  void signUp(BuildContext context) async {
    try {
      if (emailController.text.isEmpty ||
          fullNameController.text.isEmpty ||
          passController.text.isEmpty ||
          userNameController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: 'One field is empty, Please fill accordingly',
          backgroundColor: Colors.red,
        );
      } else if (pickedImage == null) {
        Fluttertoast.showToast(
          msg: 'Please Pick a profile Image',
          backgroundColor: Colors.red,
        );
      } else {
        inProgress = true;
        notifyListeners();

        await userAuth.registerWithEmailandPass(
          email: emailController.text,
          password: passController.text,
          fullName: fullNameController.text,
          userName: userNameController.text,
          avatar: uploadUrl ?? '',
        );
        await uploadImage();
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
