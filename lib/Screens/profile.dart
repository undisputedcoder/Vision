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
    final size = MediaQuery.of(context).size;

    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "Profile",
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(15, size.height * 0.14, 15, 15),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('Assets/default-user.png'),
                    radius: 50.0,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Name'),
                          subtitle: Text('Admin'),
                          leading: Icon(CupertinoIcons.person),
                        ),
                        ListTile(
                          title: Text('Email'),
                          subtitle: Text('${_currentUser.email}'),
                          leading: Icon(CupertinoIcons.mail),
                        ),
                        ListTile(
                          title: Text('Role'),
                          subtitle: Text("Management"),
                          leading: Icon(Icons.work_outline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            CupertinoIcons.square_arrow_right,
                            color: CupertinoColors.systemRed,
                          ),
                          Text(
                            " Log Out",
                            style: TextStyle(color: CupertinoColors.systemRed),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              FirebaseAuth.instance.signOut();
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
