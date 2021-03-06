import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skype_app/models/user.dart';
import 'package:skype_app/screens/chatscreens/chat_screen.dart';
import 'package:skype_app/utils/call_utilities.dart';
import 'package:skype_app/utils/permissions.dart';

final secondaryColor = Colors.lightBlue;

class DialogHelpers {
  static Dialog getProfileDialog({
    @required BuildContext context,
    String id,
    String imageUrl,
    String name,
    User d,
    User u,
    GestureTapCallback onTapMessage,
    GestureTapCallback onTapCall,
    GestureTapCallback onTapVideoCall,
    GestureTapCallback onTapInfo,
  }) {
    Widget image = imageUrl == null
        ? SizedBox(
            child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            height: 250.0,
            child: Center(
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 120.0,
              ),
            ),
          ))
        : Image(
            image: CachedNetworkImageProvider(imageUrl),
            height: 400,
            width: 400,
          );
    return new Dialog(
      shape: RoundedRectangleBorder(),
      child: Container(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                child: Stack(
                  children: <Widget>[
                    image,
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiver: d,
                          ),
                        )),
                    color: secondaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    onPressed: () async => await Permissions
                            .cameraAndMicrophonePermissionsGranted()
                        ? CallUtils.dial(from: u, to: d, context: context)
                        : {},
                    color: secondaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static showRadioDialog(List allOptions, String title, Function getText,
      BuildContext context, option, bool isActions, onChanged) {
    showDialog(
        barrierDismissible: !isActions,
        context: context,
        builder: (context) {
          List<Widget> widgets = [];
          for (dynamic opt in allOptions) {
            widgets.add(
              ListTileTheme(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                child: RadioListTile(
                  value: opt,
                  title: Text(
                    getText(opt),
                    style: TextStyle(fontSize: 18.0),
                  ),
                  groupValue: option,
                  onChanged: (value) {
                    onChanged(value);
                    Navigator.of(context).pop();
                  },
                  activeColor: secondaryColor,
                ),
              ),
            );
          }

          return AlertDialog(
            contentPadding: EdgeInsets.only(bottom: 8.0),
            title: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widgets,
                    ),
                  ),
                ),
              ],
            ),
            actions: !isActions
                ? null
                : <Widget>[
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
          );
        });
  }
}
