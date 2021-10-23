import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(int mode){
    if(mode==0){
      themeMode = ThemeMode.system;
    }else if(mode==1){
      themeMode = ThemeMode.light;
    }else{
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}



class MyThemes{
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
  );
}