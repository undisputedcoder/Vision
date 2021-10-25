import 'package:apple/Authentication/fire_auth.dart';
import 'package:apple/Authentication/local_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Widgets/wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apple/Screens/home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late FocusNode _focusEmail;
  late FocusNode _focusPassword;
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _focusEmail = FocusNode();
    _focusPassword = FocusNode();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: SafeArea(
        child: Localizations(
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
                duration: Duration(milliseconds: 1000),
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
                        color: keyboardOpen
                            ? Color(0xff00b09b)
                            : CupertinoColors.white,
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
                        color: keyboardOpen
                            ? Color(0xff00b09b)
                            : CupertinoColors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) =>
                            Validator.validateEmail(email: value),
                        obscureText: false,
                        style: TextStyle(
                          color: Color(0xff00b09b),
                          fontSize: 14.0,
                        ),
                        cursorColor: Color(0xff00b09b),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            CupertinoIcons.mail,
                            size: 18.0,
                            color: Color(0xff00b09b),
                          ),
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff00b09b),
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff00b09b),
                          ),
                          focusColor: Color(0xff00b09b),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        validator: (value) =>
                            Validator.validatePassword(password: value),
                        obscureText: !_passwordVisible,
                        style: TextStyle(
                          color: Color(0xff00b09b),
                          fontSize: 14.0,
                        ),
                        cursorColor: Color(0xff00b09b),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            CupertinoIcons.lock,
                            size: 18.0,
                            color: Color(0xff00b09b),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18,
                              color: Color(0xff00b09b),
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff00b09b),
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff00b09b),
                          ),
                          focusColor: Color(0xff00b09b),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color(0xff00b09b),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.fromBorderSide(BorderSide.none),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 60.0,
                              child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color(0xff00b09b),
                                    minimumSize: Size(double.infinity, 60),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      User? user = await FireAuth
                                          .signInUsingEmailPassword(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );

                                      if (user != null) {
                                        final localAuthIsAvail =
                                            await LocalAuthApi
                                                .localAuthIsAvail();

                                        if (localAuthIsAvail) {
                                          final authenticationSuccessful =
                                              await LocalAuthApi.authenticate();

                                          if (authenticationSuccessful) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(user: user)),
                                            );
                                          }
                                        } else {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage(user: user)),
                                          );
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => CupertinoAlertDialog(
                                              title: Text('Login Failed'),
                                              content: Text(
                                                  'Invalid username or password.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => {
                                                    Navigator.pop(context, 'OK'),
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text('Marketable Mobile Apps 2021'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Validator {
  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Please enter your email.';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Invalid email.';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Please enter your password.';
    } else if (password.length < 6) {
      return 'Invalid password.';
    }

    return null;
  }
}
