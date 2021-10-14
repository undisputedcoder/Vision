import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Widgets/text_field.dart';
import 'package:apple/Widgets/button.dart';
import 'package:apple/Widgets/wave.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Stack(
          children: [
            Container(
              height: size.height - 200.0,
              color: Color(0xff00b09b),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 3.0,
                color: CupertinoColors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: keyboardOpen ? Color(0xff00b09b) : CupertinoColors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 170,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log in to access your account.',
                    style: TextStyle(
                      color: keyboardOpen ? CupertinoColors.white : CupertinoColors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFieldWidget(
                    obscureText: false,
                    hintText: 'Email',
                    prefixIconData: CupertinoIcons.mail,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFieldWidget(
                    obscureText: true,
                    hintText: 'Password',
                    prefixIconData: Icons.lock_outline,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ButtonWidget(title: 'Login', hasBorder: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}