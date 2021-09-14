import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Profile'),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 110.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                // Change to AssetImage later.
                backgroundImage: AssetImage(
                    'Assets/default-user.png'),
                radius: 50.0,
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
              'User 1',
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
              'user1@hotmail.com',
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
                width: 100.0,
                child: CupertinoButton.filled(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Icon(
                        CupertinoIcons.square_arrow_right,
                      ),
                      Text(" Logout",)
                    ]
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                        CupertinoPageRoute(builder: (context) {
                          return MyApp();
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
    );
  }
}
