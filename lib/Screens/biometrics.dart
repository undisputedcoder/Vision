import 'package:flutter/material.dart';
import 'package:apple/Screens/home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:apple/Screens/login.dart';

class BiometricsPage extends StatefulWidget {
  const BiometricsPage({Key? key}) : super(key: key);

  @override
  _BiometricsPageState createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<BiometricsPage> {
  @override
  void initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    bool isDeviceSupported = await localAuth.isDeviceSupported();

    print(canCheckBiometrics);
    print(isDeviceSupported);

    if (canCheckBiometrics && isDeviceSupported) {
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Scan to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      if (didAuthenticate) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
