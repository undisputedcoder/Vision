import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MaterialApp(
      home: MyPage(),
    ));

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    checkGeolocator();
  }

  checkGeolocator() async {
    double kilometersPerHour = 0.0;
    bool isPassenger = false;
    const double averageRunningSpeed = 9.4;

    Geolocator.getPositionStream(
            intervalDuration: const Duration(seconds: 1),
            desiredAccuracy: LocationAccuracy.high)
        .listen((position) {
      kilometersPerHour = position.speed * 3.6;
      print(kilometersPerHour);

      if (kilometersPerHour > averageRunningSpeed) {
        if (!isPassenger) {
          showAlert(context);
          isPassenger = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alert Check"),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("You're going too fast!"),
              content: Column(
                children: const <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  /*
                  Icon(
                    CupertinoIcons.speedometer,
                    size: 100.0,
                    color: CupertinoColors.systemRed,
                  ),
                   */
                  GradientIcon(
                    CupertinoIcons.speedometer,
                    125.0,
                    LinearGradient(
                      colors: <Color>[
                        CupertinoColors.systemYellow,
                        CupertinoColors.systemOrange,
                        CupertinoColors.systemRed,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      'This app should not be used while operating machinery.'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context, "I'M A PASSENGER"),
                  },
                  child: const Text("I'M A PASSENGER"),
                ),
              ],
            ));
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: CupertinoColors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
