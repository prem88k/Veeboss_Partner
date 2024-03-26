import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart';
import 'package:veeboss_partner/Contants/Colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Contants/Api.dart';
import '../Presentation/rounded_button.dart';

class SignUPOtpPage extends StatefulWidget {
  const SignUPOtpPage({Key? key}) : super(key: key);

  @override
  State<SignUPOtpPage> createState() => _SignUPOtpPageState();
}

class _SignUPOtpPageState extends State<SignUPOtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  late SharedPreferences prefs;
  bool isVisibleV = false;
  bool isloading = false;

  void showWidget() {
    setState(() {
      isVisibleV = !isVisibleV;
    });
  }

  late String token;
  String? verificationCode;

  int _secondsRemaining = 60; // Initial time for the timer
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the screen is first initialized
    startTimer();
  }

  void startTimer() {
    // Create a timer that ticks every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // If the timer reaches 0, stop the timer
          _timer.cancel();
        }
      });
    });
  }

  void resendOTP() {
    // Add your logic for OTP resend here
    // For example, send a new OTP and update the timer
    // For now, we'll just reset the timer
    setState(() {
      _secondsRemaining = 60;
    });
    startTimer(); // Restart the timer after resending OTP
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  getToken() async {
    token = prefs.getString("token")!;
    print("token $token");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Size size = MediaQuery.of(context).size;
    return
      Scaffold(
        backgroundColor: appBackground,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.1,
                left: size.width * 0.055,
                right: size.width * 0.055),
         //   margin: EdgeInsets.only(left:ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30)  ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpeg",
                      fit: BoxFit.fill,
                      height: size.height * 0.15,
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Verify Your Email', style: TextStyle(
                    color: appButton,
                    fontSize: ScreenUtil().setWidth(18),
                    fontFamily: 'poppins',
                    letterSpacing: 1.5,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                Container(
                  height: ScreenUtil().setHeight(55),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter the OTP sent to Example@gmail.com', style: TextStyle(
                            color: primaryTextColor,
                            fontSize: ScreenUtil().setWidth(13),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),

                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter a different Email Address', style: TextStyle(
                            color: appText,
                            fontSize: ScreenUtil().setWidth(12),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Theme(

                  data: Theme.of(context)
                      .copyWith(
                    unselectedWidgetColor:
                    appText,
                  ),
                  child: OtpTextField(
                      mainAxisAlignment: MainAxisAlignment.center,
                      numberOfFields: 4,
                      borderRadius: BorderRadius.circular(20.0),
                      disabledBorderColor: appText,
                      enabledBorderColor: primaryTextColor,
                      focusedBorderColor: appText,
                      borderColor:appText ,
                      cursorColor: appButton,
                      textStyle: TextStyle(
                        color: primaryColor,
                        fontSize: ScreenUtil().setWidth(12),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor:appButton,
                      filled: true,
                      borderWidth: 0,
                      fieldWidth: ScreenUtil().setWidth(50),
                      /*onCodeChanged: (String code) {
                          print(code);
                          _otpController.text = code;
                        },*/
                      onSubmit: (code) {
                        print("OTP is => $code");
                        _otpController.text = code;
                      } ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                GestureDetector(
                  onTap: () {
                  //  ResendOTP();
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(40),
                    child: Center(
                      child: Text(
                        (_secondsRemaining > 0) ? "Time remaining: 00:$_secondsRemaining seconds" : "Resend OTP", style: TextStyle(
                        color: primaryTextColor,
                        fontSize: ScreenUtil().setWidth(12),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(15),
                ),
                GestureDetector(
                    onTap: (){
                      //RegisterOTP();
                    },
                    child: RoundedButton(text: 'Submit', press: (){},color: appButton,)),

              ],
            ),
          ),
        ),
      );

  }

 /* Future<void> ResendOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('access_token')}--");
    setState(() {
      isloading = true;
    });

    final queryParametersNearest = {
      'email': prefs.getString('email'),
    };
    var uri = Uri.https('lobby.codeandcode.xyz', '/public/api/resendOtp', queryParametersNearest);
    final headers = {
      'Authorization': 'Bearer ${prefs.getString('access_token')}'
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);
    print("Resent OTP::$responseBody");
    if (statusCode == 200) {
      if (getdata["status"]) {
        setState(() {
          isloading = false;

        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
    }
  }*/

  /*Future<void> RegisterOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---${prefs.getString('access_token')}--");
    print(_otpController.text);
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/public/api/verifyOtp',
    );

    final headers = {'Authorization': 'Bearer ${prefs.getString('access_token')}'};

    Map<String, dynamic> body = {
      'otp': _otpController.text,
    };
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,

    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);
    print("OTP Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["status"]) {
        setState(() {
          isloading = false;
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PersonalDetailsPage();
              },
            ),
          );
        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
    }
  }*/

}
