import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/home.dart';
import 'package:apple/Screens/biometrics.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _rememberme = false;

  Widget _buildEmailTF() {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ID',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              //decoration: ????
              height: 60.0,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: 'Enter your ID',
                  //hintStyle: ????????????
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildPasswordTF() {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Password',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                )),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              //decoration: ????
              height: 60.0,
              child: TextField(
                obscureText: true,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    CupertinoIcons.lock,
                  ),
                  hintText: 'Enter your Password',
                  //hintStyle: ????????????
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildForgotPasswordBtn() {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => print('Forgot Password button pressed'),
            child: Text('Forgot Password?'), //style????
          ),
        ));
  }

  Widget _buildRememberMeCheckBox() {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Container(
            height: 20.0,
            child: Row(children: <Widget>[
              Theme(
                  data: ThemeData(),
                  child: Checkbox(
                    value: _rememberme,
                    checkColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _rememberme = value;
                      });
                    },
                  )),
              Text('Remember me',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                  ))
            ])));
  }

  Widget _buildLoginBtn() {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: CupertinoButton.filled(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) {
                      return BiometricsPage();
                    }),
                  );
                },
                padding: EdgeInsets.all(15.0),
                child: Text('LOGIN',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    _buildEmailTF(),
                    SizedBox(height: 30.0),
                    _buildPasswordTF(),
                    _buildForgotPasswordBtn(),
                    _buildRememberMeCheckBox(),
                    _buildLoginBtn(),
                  ],
                )),
          )
        ],
      ),
    );
  }
}