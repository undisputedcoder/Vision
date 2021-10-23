import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Profile extends StatefulWidget {
  final User user;
  const Profile({required this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Profile'),
        ),
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      // Change to AssetImage later.
                      backgroundImage: AssetImage(
                          'Assets/default-user.png'),
                      radius: 40.0,
                    ),
                  ),
                  Divider(
                    height: 90.0,
                    color: Colors.black,
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                   // 'User 1',
                    '${_currentUser.displayName}',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    //'user1@hotmail.com',
                    '${_currentUser.email}',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Role',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Operator',
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Container(
                      width: 120.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CupertinoColors.opaqueSeparator
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: CupertinoButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(
                              CupertinoIcons.square_arrow_right,
                              color: CupertinoColors.destructiveRed,
                            ),
                            Text(" Log Out",
                              style: TextStyle(
                                color: CupertinoColors.destructiveRed
                              ),
                            ),
                          ]
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                              CupertinoPageRoute(builder: (context) {
                                FirebaseAuth.instance.signOut();
                                return LoginPage();
                              }),
                          );
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
