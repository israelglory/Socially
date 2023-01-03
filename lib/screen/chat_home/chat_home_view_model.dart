import 'package:firebase_storage/firebase_storage.dart';
import 'package:socially/constants/firebase_constants.dart';
import 'package:socially/exports.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/screen/auth_screen/login/login_view.dart';
import 'package:socially/services/user_service/user_auth.dart';
import 'package:stacked/stacked.dart';

class ChatHomeViewModel extends BaseViewModel {
  final UserAuth userAuth = UserAuth();
  TextEditingController textEditingController = TextEditingController();
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  int _limit = 20;
  int _limitIncrement = 20;
  final ScrollController listScrollController = ScrollController();
  UserModel user = UserModel();

  Future<void> initState() async {
    listScrollController.addListener(scrollListener);
    await userData();
  }

  void logOut(BuildContext context) async {
    await userAuth.logOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Future<void> userData() async {
    final userinfo = await UserAuth().getUserData();

    user = UserModel(
      avatar: userinfo['avatar'],
      email: userinfo['email'],
      fullName: userinfo['fullName'],
      uid: userinfo['uid'],
      userName: userinfo['userName'],
    );
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      _limit += _limitIncrement;
      notifyListeners();
    }
  }

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(
    String pathCollection,
  ) {
    if (textEditingController.text.isNotEmpty) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(_limit)
          .where(FirestoreConstants.nickname,
              isEqualTo: textEditingController.text)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(pathCollection)
          .where(
            'uid',
            isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .limit(_limit)
          .snapshots();
    }
  }
}
