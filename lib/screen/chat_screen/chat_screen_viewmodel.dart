import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/constants/firebase_constants.dart';
import 'package:socially/exports.dart';
import 'package:socially/services/messaging_service/message_service.dart';
import 'package:stacked/stacked.dart';

class ChatScreenViewModel extends BaseViewModel {
  final MessagingService chatService = MessagingService();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<QueryDocumentSnapshot> listMessage = [];
  String peerId = '';
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  void initState(String peerId) {
    peerId = peerId;
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
    notifyListeners();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      _limit += _limitIncrement;
      notifyListeners();
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear

      isShowSticker = false;
      notifyListeners();
    }
  }

  void readLocal() {
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }

    chatService.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: peerId},
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        isLoading = true;
        notifyListeners();
        uploadFile();
      }
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();

    isShowSticker = !isShowSticker;
    notifyListeners();
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatService.uploadFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();

      isLoading = false;
      onSendMessage(imageUrl, TypeMessage.image);
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatService.sendMessage(
          content, type, groupChatId, currentUserId, peerId);
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.blue);
    }
  }
}
