import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_app/models/contact.dart';
import 'package:skype_app/models/user.dart';
import 'package:skype_app/provider/user_provider.dart';
import 'package:skype_app/resources/firebase_methods.dart';
import 'package:skype_app/screens/chatscreens/chat_screen.dart';
import 'package:skype_app/screens/chatscreens/widgets/cached_image.dart';
import 'package:skype_app/utils/universal_variables.dart';
import 'package:skype_app/widgets/custom_tile.dart';
import 'package:recase/recase.dart';
import 'last_message_container.dart';
import 'online_dot_indicator.dart';

class ContactViews extends StatelessWidget {
  final User contact;
  final FirebaseMethods _authMethods = FirebaseMethods();

  ContactViews(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final FirebaseMethods _chatMethods = FirebaseMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              receiver: contact,
            ),
          )),
      title: Text(
        (contact != null ? contact.name : null) != null
            ? contact.name.titleCase
            : "..",
        style:
            TextStyle(color: Colors.black87, fontFamily: "Arial", fontSize: 16),
      ),
      subtitle: LastMessageContainer(
        stream: _chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid,
            ),
          ],
        ),
      ),
    );
  }
}
