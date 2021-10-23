import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:apple/Widgets/text_field.dart';
import 'package:apple/Widgets/button.dart';
import 'package:apple/Widgets/wave.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apple/Auth/fire_auth.dart';
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
  void initState(){
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _focusEmail = FocusNode();
    _focusPassword = FocusNode();
    _passwordVisible = false;
  }

  @override
  void dispose(){
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
                    Padding(padding: const EdgeInsets.only(top: 50)),
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(email: value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffeeeeee),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:  BorderSide(color: Colors.white ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            CupertinoIcons.mail,
                            color: Color(0xff00b09b),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Color(0xff00b09b)),
                      ),
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      obscureText: !_passwordVisible,
                      validator: (value) => Validator.validatePassword(password: value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffeeeeee),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:  BorderSide(color: Colors.white ),

                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.lock_outline,
                            color: Color(0xff00b09b),
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color(0xff00b09b)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                            color: Color(0xff00b09b),
                          ),
                          onPressed: (){
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                ),
                                color: Color(0xff00b09b),
                                onPressed: () async{
                                  if(_formKey.currentState!.validate()){
                                    User? user = await FireAuth.signInUsingEmailPassword(email: _emailTextController.text, password: _passwordTextController.text,);
                                    if(user!=null) {
                                      Navigator.of(context)
                                          .pushReplacement(
                                        MaterialPageRoute(builder: (context) => Main()),
                                      );
                                    }else{
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Text("Auth Exception!"),
                                            content: Text("Invalid username or password."),
                                            actions: <Widget>[
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    child: Text("Log In again"),
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                  )
                                                ]
                                              )
                                            ]
                                          );
                                        }
                                      );
                                    }
                                  }
                                }

                            ),
              ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Vision 2021'),
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
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }
}
