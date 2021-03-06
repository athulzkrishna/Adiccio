import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_app/provider/user_provider.dart';
import 'package:skype_app/screens/pageviews/widgets/user_details_container.dart';
import 'package:skype_app/utils/universal_variables.dart';
import 'package:skype_app/utils/utilities.dart';

class UserCircle extends StatefulWidget {
  @override
  _UserCircleState createState() => _UserCircleState();
}

class _UserCircleState extends State<UserCircle> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        barrierColor: Colors.blue[50].withOpacity(0.9),
        backgroundColor: Colors.transparent,
        //backgroundColor: UniversalVariables.blackColor,
        builder: (context) => UserDetailsContainer(),
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: UniversalVariables.separatorColor,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UniversalVariables.lightBlueColor,
                  fontSize: 13,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: UniversalVariables.blackColor, width: 2),
                    color: UniversalVariables.onlineDotColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
