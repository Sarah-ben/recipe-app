import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipeapp/shared/style/theme/colors.dart';

ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor:Colors.black,
    primarySwatch: Colors.orange,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor(),
    ),

    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.white
        ),

        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),

        //didn't work
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white
            )
        ),

        backgroundColor: Colors.black,
        elevation: 0.0
    )
);
ThemeData lightTheme= ThemeData(
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent
    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        elevation: 20.0
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:const AppBarTheme(

        iconTheme: IconThemeData(
            color: Colors.black
        ),

        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        color: Colors.white,
        elevation: 0.0
    )
);