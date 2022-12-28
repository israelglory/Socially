import 'package:flutter/cupertino.dart';
import 'package:socially/constants/firebase_constants.dart';
import 'package:socially/exports.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/screen/all_users/user_list_viewmodel.dart';
import 'package:socially/widgets/user_item.dart';
import 'package:stacked/stacked.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserListViewModel>.reactive(
      onModelReady: (model) {
        model.initState();
      },
      viewModelBuilder: () => UserListViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Socially'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    model.logOut(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.square_arrow_up,
                  ),
                ),
              )
            ],
          ),
          body: CustomScrollView(
            slivers: [
              /*SliverToBoxAdapter(
                child: Stories(),
              ),*/
              SliverToBoxAdapter(
                child: StreamBuilder<QuerySnapshot>(
                  stream: model.getStreamFireStore(
                      FirestoreConstants.pathUserCollection),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if ((snapshot.data?.docs.length ?? 0) > 0) {
                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            UserModel userChat = UserModel.fromFirestore(
                                snapshot.data!.docs[index]);
                            return UserItem(
                              userModel: userChat,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          controller: model.listScrollController,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No users"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                /*SliverList(
                delegate: SliverChildBuilderDelegate(_delegate),
              )*/
              ),
            ],
          ),
        );
      },
    );
  }
}
