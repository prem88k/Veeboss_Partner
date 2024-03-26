import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Contants/Colors.dart';
import '../AppDrawer.dart';
import '../Employer/NotificationScreen.dart';
import '../HomeScreen/EmployeeHomeScreen.dart';
import '../SearchPage.dart';
import '../agent/ProfilePage.dart';
import 'ApploedJObsPage.dart';
import 'ChatScreen.dart';
import 'EmployeeSaveJobsScreen.dart';
import 'ProfileNavigationPAge.dart';

class BottomNavigationBarEmploye extends StatefulWidget {
  BottomNavigationBarEmploye();

  @override
  _BottomNavigationBarEmployeState createState() => _BottomNavigationBarEmployeState();
}

class _BottomNavigationBarEmployeState extends State<BottomNavigationBarEmploye> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new EmployeeHomeScreen();
      case 1:
        return new EmployeeAppliedJobListPage();
      case 2:
        return new EmployeeSaveJobsScreen();
     /* case 3:
        return new ChatPage();*/
      case 3:
        return new ProfilePage();
      default:
        return EmployeeHomeScreen();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: appBackground,
          key: _scaffoldKey,
          appBar: AppBar(
            bottomOpacity: 0,

            shape: Border(
                bottom: BorderSide(
                    color: appBackground,
                    width: 0.1
                )
            ),
            elevation: 0,
            title: /*Image(image: AssetImage("assets/images/appbar_logo.JPEG"),
            height: size.height * 0.060,
            width: size.width * 0.2,),*/
            Text(
             "Veeboss",
              style: TextStyle(
                color: appButton,
                fontSize: 18,
                fontFamily:
                'railway',
                fontWeight: FontWeight.bold,
              ),
            ),
            /*Text(currentIndex == 0 ? "All Jobs"  : currentIndex == 1 ? "Applied Job"  : currentIndex == 2 ? "Saved Job" : currentIndex == 3 ? "Chat Screen" : "Profile" , style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily:
              'railway',
              fontWeight: FontWeight.bold,
            ),),*/
            backgroundColor: appBackground,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: appButton,),
              tooltip: 'Menu Icon',
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileNavigationPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.person_outline, color: appButton),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NotificationScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.notifications_outlined, color: appButton),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.search, color: appButton),
            ),
          ],
          ),
          drawer: AppDrawer(context),
          body: callPage(currentIndex),
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: appBackground,
                  textTheme: Theme.of(context).textTheme.copyWith(
                      caption: TextStyle(color: appText.withOpacity(0.15)))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: appButton, width: 0.2))),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: appText,
                  selectedItemColor: appButton,
                  currentIndex: currentIndex,
                  unselectedLabelStyle:  TextStyle(
                    fontFamily: 'railway',
                    fontWeight: FontWeight.normal,
                    fontSize: size.width * 0.03,
                    color: appText) ,
                  selectedLabelStyle:  TextStyle(
                    fontFamily: 'railway',
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.03,
                    color: Colors.white),
                  onTap: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                         Icons.home,
                          size: 21.0,
                        ),
                        // ignore: deprecated_member_use
                        label: "Home"),

                    BottomNavigationBarItem(
                        icon: Icon(
                            Icons.layers,
                          size: 22.0,
                        ),
                        label: "History"),

                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.save_alt_outlined,
                          size: 22.0,
                        ),
                        label: "Saved"),

                  /*  BottomNavigationBarItem(
                        icon: Icon(
                          Icons.chat_outlined,
                          color: whiteTextColor,

                          size: 22.0,
                        ),
                        label: "Chat"),*/

                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          size: 22.0,
                        ),
                        // ignore: deprecated_member_use
                        label: "Profile"),
                  ],
                ),
              )),
        ),
      );
  }
  Future<bool> _onWillPop() async {
    Size size = MediaQuery.of(context).size;

    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: whiteTextColor,
        shape: Border.all(color: whiteTextColor),
        title: Row(children: [
          Image.asset(
            'assets/images/logo.jpeg',
            width: size.height * 0.085,
            height: size.height * 0.065,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: size.width * 0.035,
          ),
          Text('Veeboss',
              style: TextStyle(
                  fontFamily: 'railway',
                  fontSize: size.height * 0.02,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold))
        ]),
        content: Text("Are You Sure, You Want To Exit the App?",
            style: TextStyle(
                fontFamily: 'railway',
                fontSize: size.height * 0.022,
                color: buttonTextColor,
                fontWeight: FontWeight.normal)),
        actions: <Widget>[
          MaterialButton(
            child: Container(
              height: size.height * 0.050,
              width:size.width * 0.25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: buttonTextColor
              ),
              child: Text(
                "YES",
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.height * 0.015,
                    color: whiteTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Yes button click.
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
          MaterialButton(
            child: Container(
              height: size.height * 0.050,
              width:size.width * 0.25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: buttonTextColor
              ),
              child: Text(
                "CANCEL",
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.height * 0.015,
                    color: whiteTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () {
              //Put your code here which you want to execute on Cancel button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    )) ??
        false;
  }

}
