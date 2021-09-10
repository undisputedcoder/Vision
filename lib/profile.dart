import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(CupertinoApp(
      home: Profile(),
    ));

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
                backgroundImage: NetworkImage(
                    'https://scontent.fper7-1.fna.fbcdn.net/v/t1.6435-9/37364114_1856065468033083_4052767939785392128_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_ohc=8eqdxKmTNCgAX_U8UMO&_nc_ht=scontent.fper7-1.fna&oh=0dc92e4603ca9a7b80be1737addbb5cf&oe=615E31F2'),
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
              'Kevin Schmidlin',
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
              'kevin.schmidlin@hotmail.com',
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Job',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Student',
            ),
            SizedBox(
              height: 40.0,
            ),
            CupertinoButton.filled(
			  // Change to Cupertino icon.
              child: Icon(
                Icons.logout,
              ),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
