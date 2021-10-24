import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final localAuth = LocalAuthentication();

  static Future<bool> localAuthIsAvail() async {
    try {
      final isDeviceSupported = await localAuth.isDeviceSupported();
      final isAvailable = await localAuth.canCheckBiometrics;
      return isAvailable && isDeviceSupported;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    try {
      return await localAuth.authenticate(
        localizedReason: 'Scan to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      return false;
    }
  }
}