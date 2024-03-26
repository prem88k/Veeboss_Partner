import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Contants/Colors.dart';
import 'Employee/BottomNavigationBarEmploye.dart';
import 'Employer/BottomNavigationBar.dart';
import 'IntroductionScreen.dart';
import 'Vendor/BottomNavigationBarVendor.dart';
import 'WelcomeScreen.dart';
import 'agent/BottomNavigationBar.dart';


class SplashScreen extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      body: Container(
        height: size.height,
        margin: EdgeInsets.only(top: size.height * 0.005),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                    fit: BoxFit.fill,
                    height: size.height * 0.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    startTime() async {
      return new Timer(Duration(milliseconds: 3000), NavigatorPage);
    }


  Future<void> NavigatorPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ?isLogging = prefs.getBool("isLogging");
    print("=-----$isLogging");
    String ?role = prefs.getString("role");
    if (isLogging == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IntroductionScreen();
          },
        ),
      );
    }
    else {
      if (isLogging) {
        /*if (role.toString().compareTo("user") == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarEmploye();
              },
            ),
          );
        }
        else */ if (role.toString().compareTo("company") == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return bottomNavigationBarEmployer();
              },
            ),
          );
        }
        else if (role.toString().compareTo("agent") == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return bottomNavigationBarT2();
              },
            ),
          );
        }
        else if (role.toString().compareTo("vendor") == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarVendor();
              },
            ),
          );
        }
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return bottomNavigationBarT2();
              },
            ),
          );
        }
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SelectRole();
            },
          ),
        );
      }
    }
  }}
