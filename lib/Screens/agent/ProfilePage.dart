import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/ProfileData.dart';
import '../../Presentation/rounded_button.dart';
import '../ChangePassword.dart';
import '../Employee/PdfViewr.dart';
import '../agent/editProfile.dart';
import 'editCompanyProfile.dart';


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _referCodeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  late String _radioValue;
  late String choice;

  bool isLoading = false;
  SharedPreferences? prefs;
  late GetProfileInformation getProfileInformation;

  @override
  void initState() {
    getProfileInformation = GetProfileInformation();
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
      // backgroundColor: Colors.white,
      body: isLoading &&prefs==null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.020,
              ),


              Container(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                alignment: Alignment.topLeft,
                child: Text("Profile Details",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.04,
                      color: appHeader
                  ),),
              ),

              SizedBox(
                height: size.height * 0.010,
              ),

              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: getProfileInformation.data?[0].profileImage == null ? Container(
                                      alignment: Alignment.topCenter,
                                      height: size.height * 0.1,
                                      width: size.height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          image: DecorationImage(
                                              image: AssetImage ("assets/images/profile.png"),
                                              fit: BoxFit.fill
                                          )
                                      )
                                  ): Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.1,
                                    width: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: buttonTextColor,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            getProfileInformation.data![0].profileImage.toString(),
                                          ),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => editProfile(getProfileInformation)
                                      ));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(size.width * 0.0),
                                           /* decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: appButton

                                            ),*/
                                            width: size.width * 0.2,
                                            height: size.height * 0.05,
                                            child: Center(
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize: size.width * 0.035,
                                                      fontWeight: FontWeight.w600,
                                                      color: appButton),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),

                             Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  getProfileInformation.data?[0].name == null ? "-"
                                  :  getProfileInformation.data![0].name!,
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontSize: size.height * 0.020,
                                      fontWeight: FontWeight.bold)
                              ),
                            ) ,

                            Divider(
                              thickness: 0.5,
                              color: primaryTextColor,
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.22,
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                      "Email ID: ",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          color: primaryTextColor,
                                          fontSize: size.height * 0.015,
                                          fontWeight: FontWeight.w600)
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                      getProfileInformation.data?[0].email == null ?
                                      "-" : getProfileInformation.data![0].email!,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          color: appText,
                                          fontSize: size.height * 0.015,
                                          fontWeight: FontWeight.w600)
                                  ),
                                ),
                              ],
                            ) ,


                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.22,
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                                "Location: ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: primaryTextColor,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.w600)
                            ),
                          ),
                            Container(
                              padding:  EdgeInsets.only(bottom: 12.0),
                              child:Text(
                                  getProfileInformation.data?[0].location == null ? "-" :
                                  getProfileInformation.data![0].location!,
                                  style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.height * 0.015,)
                              ),
                            ),
                            ]
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.22,
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Text(
                                "Gender: ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: primaryTextColor,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.w600)
                            ),
                          ),
                            Container(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                  getProfileInformation.data?[0].gender == null ?
                                  "-" : getProfileInformation.data![0].gender! ,
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600)
                              ),
                            ),
                          ]
                       ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.22,
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                "Age: ",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: primaryTextColor,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.w600)
                            ),
                          ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                  getProfileInformation.data?[0].age.toString() == null ?
                                  "-" : getProfileInformation.data![0].age.toString() ,
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600)
                              ),
                            ),
                          ]
                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.015,
              ),

              SizedBox(
                height: size.height * 0.020,
              ),

              Container(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                alignment: Alignment.topLeft,
                child: Text("Company Details",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.04,
                      color: appHeader
                  ),),
              ),

              SizedBox(
                height: size.height * 0.010,
              ),

              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.all(5.0),
                                  child: getProfileInformation.data?[0].companyLogo == null ? Container(
                                      alignment: Alignment.topCenter,
                                      height: size.height * 0.1,
                                      width: size.height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: primaryTextColor, width: 0.5),
                                      ),
                                    child: Center(
                                      child: Image(
                                      image: AssetImage ("assets/images/company_logo.png",),
                                       alignment: Alignment.center,
                                      fit: BoxFit.contain,
                                        height: size.height * 0.055,
                                     ),
                                    )
                                  ):
                                  Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.1,
                                    width: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: buttonTextColor,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            getProfileInformation.data![0].companyLogo.toString(),
                                          ),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => editCompanyProfile(getProfileInformation)
                                      ));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(size.width * 0.0),
                                          /*  decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: appButton

                                            ),*/
                                            width: size.width * 0.2,
                                            height: size.height * 0.05,
                                            child: Center(
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontFamily: 'railway',
                                                      fontSize: size.width * 0.035,
                                                      fontWeight: FontWeight.w600,
                                                      color: appButton),
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  getProfileInformation.data?[0].companyName == null ? "-" :
                                  getProfileInformation.data![0].companyName!.toString(),
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appHeader,
                                      fontSize: size.height * 0.020,
                                      fontWeight: FontWeight.bold)
                              ),
                            ) ,

                            Divider(
                              thickness: 0.5,
                              color: primaryTextColor,
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),


                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.4,
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                      "Website: ",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          color: primaryTextColor,
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.w600)
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  width: size.width * 0.7,
                                  child: Text(
                                      getProfileInformation.data?[0].companyUrl == null ?
                                      "-" : getProfileInformation.data![0].companyUrl!,
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          color: appText,
                                          fontSize: size.height * 0.016,
                                          fontWeight: FontWeight.w600)
                                  ),
                                ),
                              ],
                            ) ,


                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        "Location: ",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: primaryTextColor,
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Container(
                                    padding:  EdgeInsets.only(bottom: 15.0),
                                    width: size.width * 0.7,
                                    child:Text(
                                        getProfileInformation.data?[0].address == null ? "-" :
                                        getProfileInformation.data![0].address!.toString(),
                                        style: TextStyle(
                                          fontFamily: 'railway',
                                          color: appText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.016,)
                                    ),
                                  ),
                                ]
                            ),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        "City: ",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: primaryTextColor,
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    width: size.width * 0.7,
                                    child: Text(
                                        getProfileInformation.data?[0].city == null ?
                                        "-" : getProfileInformation.data![0].city.toString() ,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: appText,
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                ]
                            ),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        "Area: ",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: primaryTextColor,
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    width: size.width * 0.7,
                                    child: Text(
                                        getProfileInformation.data?[0].area == null ?
                                        "-" : getProfileInformation.data![0].area.toString() ,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: appText,
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                ]
                            ),

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        "About Comapany: ",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: primaryTextColor,
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    width: size.width * 0.7,
                                    child: Text(
                                         getProfileInformation.data?[0].aboutCompany == null ?
                                        "-" : getProfileInformation.data![0].aboutCompany.toString() ,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: appText,
                                            fontSize: size.height * 0.016,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.020,
              ),

              Container(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                alignment: Alignment.topLeft,
                child: Text("Company Document",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.04,
                      color: appHeader
                  ),),
              ),

              SizedBox(
                height: size.height * 0.010,
              ),

              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: appButton,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(15.0),),
                    color: appBackground,
                    child: Container(
                      width: size.width * 1.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        "GST Certificate",
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            color: primaryTextColor,
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                ]
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.all(5.0),
                                  child: getProfileInformation.data?[0].resume == null && "https://yourang.shop/veeboss/public/resume/" == null  ? Container(
                                      alignment: Alignment.topCenter,
                                      height: size.height * 0.02,
                                      width: size.height * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: primaryTextColor, width: 0.5),
                                      ),
                                      child: Center(
                                        child: Image(
                                          image: AssetImage ("assets/images/company_logo.png",),
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                          height: size.height * 0.055,
                                        ),
                                      )
                                  ):
                                  Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.2,
                                    width: size.height * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryTextColor, width: 0.5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            getProfileInformation.data![0].resume.toString(),
                                          ),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.025,
              ),

              Padding(
                padding: EdgeInsets.only(left: 18.0, right:18.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChangePassword(getProfileInformation.data![0].email);
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.all(size.width * 0.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: appButton

                                ),
                                width: size.width * 0.55,
                                height: size.height * 0.06,
                                child: Center(
                                    child: Text(
                                      "Change Password",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.width * 0.03,
                                          color: whiteTextColor),
                                    ))),
                          ],
                        ),
                      ),
                    ),

                   /* Padding(
                      padding: EdgeInsets.only(left: 18.0, right:18.0,),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChangePassword(getProfileInformation.data![0].email);
                              },
                            ),
                          );
                        },
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: appButton,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15.0),),
                            color: appBackground
                            ,
                            child: Container(
                              width: size.width * 1.0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.all(size.width*0.015),
                                      child: Text('Change Password',
                                          style: TextStyle(
                                            fontFamily: 'railway',
                                            color: appHeader,
                                            fontWeight: FontWeight.bold,
                                            fontSize: size.height * 0.018,)),
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: size.height * 0.020,
                                            color: appHeader,
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> getProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/profile/${prefs.getString("userId")}',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("Profile::$responseBody");
    if (statusCode == 200) {
      getProfileInformation = GetProfileInformation.fromJson(jsonDecode(responseBody));
      setState(() {
        isLoading = false;
        _userNameController.text=getProfileInformation.data![0].name!;
        _emailController.text=getProfileInformation.data![0].email!;
        _ageController.text=getProfileInformation.data![0].age.toString();
        _numberController.text=getProfileInformation.data![0].contactNo.toString();
        _referCodeController.text=getProfileInformation.data![0].referenceCode.toString();
      });
    }
  }
}

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String? txt, image;
  GestureTapCallback? tap;
  double ?padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt!,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: appText,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'railway',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: appText,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}

class categoryNew extends StatelessWidget {
  @override
  String ?txt, value;
  double ?padding;

  categoryNew({this.txt, this.value, this.padding});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: padding!),
                      /*child: Image.asset(
                        image,
                        height: 45.0,
                      ),*/
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        txt!,
                        style: TextStyle(
                            fontFamily: 'railway',
                            fontSize: 13.0,
                            color: appText,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: size.width * 0.35,
                        child: Text(
                          value!,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'railway',
                              color: appText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 80) {
      firstHalf = widget.text.substring(0, 80);
      secondHalf = widget.text.substring(80, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf,
        style: TextStyle(
          fontSize: size.height * 0.015,
          color: appText,
          fontFamily: 'railway',),
      )
          : new Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Row(

              children: [
                Container(
                    alignment: Alignment.topLeft,
                    width: size.width * 0.6,
                    child:  Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                      style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontFamily: 'railway',
                          color: appText
                      ),)),
                InkWell(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          flag ? "Read More" : "Read Less",
                          style:  TextStyle(color: appHeader,
                            fontSize: size.height * 0.015,
                            fontFamily: 'railway',),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
