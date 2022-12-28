import 'package:socially/exports.dart';
import 'package:socially/models/user_model.dart';
import 'package:socially/widgets/avatar.dart';

import '../screen/chat_screen/chat_screen_view.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatScreen(
              userModel: userModel,
            );
          }),
        );
      },
      child: Container(
        //height: 100,
        //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 0.2,),),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Avatar.large(url: userModel.avatar),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        userModel.fullName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        userModel.userName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
