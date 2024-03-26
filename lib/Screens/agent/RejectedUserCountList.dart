import 'package:flutter/material.dart';
import 'package:veeboss_partner/Models/Vendor/GetAppCountData.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veeboss_partner/Models/Vendor/GetAppCountData.dart';
import '../../Contants/Api.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/GetApplicantUserData.dart';
import '../../Models/Employee/MyJobs.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import '../Employee/PdfViewr.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Employee/PdfViewr.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dotted_line/dotted_line.dart';
import '../InvitePage.dart';

class RejectedUserCountList extends StatefulWidget {
  List<RejectedUser>? appliedList;
  RejectedUserCountList(this.appliedList);

  @override
  State<RejectedUserCountList> createState() => _RejectedUserCountListState();
}

class _RejectedUserCountListState extends State<RejectedUserCountList> {

  bool jobsLoading = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: appBackground,
        appBar: AppBar(
          backgroundColor: appBackground,
          iconTheme: IconThemeData(
              color: appText
          ),
          shape: Border(
              bottom: BorderSide(
                  color: borderColors,
                  width: 0.5
              )
          ),
          elevation: 1,
          centerTitle: true,
          title: Text("Rejected Users",
              style: TextStyle(fontFamily: "railway", color: appText)),
          actions: <Widget>[
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: jobsLoading?Center(child: CircularProgressIndicator(color: appText,)):SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.020,
              ),

              widget.appliedList!.length == 0
                  ? Center(
                  child: Container(
                    //  margin: EdgeInsets.only(top: size.height * 0.4),
                      child: Text(
                        "No User Found",
                        style: TextStyle(
                            fontFamily: 'railway',
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ))):
              Container(
                child: ListView.builder(
                  primary: false,
                  scrollDirection:
                  Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.appliedList!.length,
                  itemBuilder:
                      (BuildContext context,
                      int index) {
                    //  status = "pending";
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width *
                                  0.025,
                              right: size.width *
                                  0.025,
                              bottom: size.width *
                                  0.015),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: abc),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Define how the card's content should be clipped
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shadowColor: bg,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: size.width*0.010,
                                  right: size.width*0.010,
                                  bottom: size.width*0.015,
                                  top: size.height*0.020),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                            12.0,
                                            top: 15.0,
                                            bottom:
                                            0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            (widget.appliedList![index].profileImage == null || widget.appliedList![index].profileImage.toString() == "")
                                                ? Container(
                                                alignment: Alignment.topCenter,
                                                height: size.height * 0.080,
                                                width: size.height * 0.080,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                    border:Border.all(color: appText),
                                                    image: DecorationImage(image: widget.appliedList![index].gender.toString() == "female" ? AssetImage("assets/images/female.png") : AssetImage("assets/images/male.png"), fit: BoxFit.fill)))
                                                : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                    border:Border.all(color: appText),
                                                    image: DecorationImage(image: NetworkImage(userProfile+widget.appliedList![index].profileImage.toString()), fit: BoxFit.fill))),
                                            SizedBox(
                                              width: size.width *
                                                  0.030,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                  size.height * 0.0),
                                              child:
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: size.width * 0.6,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(
                                                            right: 0.0,
                                                            left: 0.0,
                                                          ),
                                                          child: Text(
                                                            widget.appliedList![index].name == null ? "-" :
                                                            widget.appliedList![index].name!,
                                                            style: TextStyle(fontFamily: 'railway',
                                                                fontSize: size.height * 0.023, fontWeight: FontWeight.bold, color: appHeader),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 0.0,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.010,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:primaryTextColor,
                                                        size: size.height * 0.020,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                        size.width * 0.005,
                                                      ),
                                                      Container(
                                                        width: size.width * 0.6,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(
                                                            right: 0.0,
                                                            left: 0.0,
                                                          ),
                                                          child: Text(
                                                            widget.appliedList![index].location!=null?widget.appliedList![index].location!:"-",
                                                            style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017,
                                                                fontWeight: FontWeight.normal, color: appText),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 0.0,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.010,
                                  ),
                                  SizedBox(
                                    height:
                                    size.height *
                                        0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        width:
                                        size.width *
                                            0.85,
                                        child:
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                              12.0,
                                              right:
                                              12.0,
                                              bottom:
                                              8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .email,
                                                color:
                                                appText,
                                                size: size.height * 0.025,
                                              ),
                                              SizedBox(
                                                width:
                                                size.width * 0.025,
                                              ),
                                              Text(
                                                widget.appliedList![index]
                                                    .email == null ?
                                                "-" :
                                                widget.appliedList![index]
                                                    .email!,
                                                style: TextStyle(
                                                    fontFamily: 'railway',
                                                    fontSize: size.height * 0.017,
                                                    fontWeight: FontWeight.normal,
                                                    color: appText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        width:
                                        size.width *
                                            0.85,
                                        child:
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                              12.0,
                                              right:
                                              12.0,
                                              bottom:
                                              8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .person,
                                                color:
                                                appText,
                                                size: size.height * 0.025,
                                              ),
                                              SizedBox(
                                                width:
                                                size.width * 0.025,
                                              ),

                                              Text(
                                                widget.appliedList![index]
                                                    .gender == null ?
                                                "-":
                                                widget.appliedList![index]
                                                    .gender!,
                                                style: TextStyle(
                                                    fontFamily: 'railway',
                                                    fontSize: size.height * 0.017,
                                                    fontWeight: FontWeight.normal,
                                                    color: appText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                  /* Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            width:
                                            size.width *
                                                0.85,
                                            child:
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  12.0,
                                                  right:
                                                  12.0,
                                                  bottom:
                                                  8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.chat,
                                                    color:
                                                    appText,
                                                    size: size.height * 0.025,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                    size.width * 0.025,
                                                  ),
                                                  Container(
                                                    width:
                                                    size.width * 0.7,
                                                    child: Text(
                                                      userList![index]
                                                          .bio == null ?
                                                          "-" :
                                                      userList![index]
                                                          .bio!,
                                                      style: TextStyle(
                                                          fontFamily: 'railway',
                                                          fontSize: size.height * 0.017,
                                                          fontWeight: FontWeight.normal,
                                                          color: appText),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),*/
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        width:
                                        size.width *
                                            0.85,
                                        child:
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                              12.0,
                                              right:
                                              12.0,
                                              bottom:
                                              8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.av_timer,
                                                color:
                                                appText,
                                                size: size.height * 0.025,
                                              ),
                                              SizedBox(
                                                width:
                                                size.width * 0.025,
                                              ),
                                              Text(
                                                widget.appliedList![index].age != null
                                                    ? widget.appliedList![index].age!.toString() + " Year"
                                                    : "-",
                                                style: TextStyle(
                                                    fontFamily: 'railway',
                                                    fontSize: size.height * 0.017,
                                                    fontWeight: FontWeight.normal,
                                                    color: appText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.7,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12.0, bottom: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.010,
                                              ),
                                              Text(
                                                "Work Experience ",
                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020, fontWeight: FontWeight.w600, color: appHeader),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.010,
                                              ),
                                              Text(
                                                widget.appliedList![index].experience == null ? "-" : widget.appliedList![index].experience!,
                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.7,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12.0, bottom: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.010,
                                              ),
                                              Text(
                                                "Skills",
                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.020, fontWeight: FontWeight.w600, color: appHeader),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.010,
                                              ),
                                              Text(
                                                widget.appliedList![index].bio != null ? widget.appliedList![index].bio! : "-",
                                                style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.017, fontWeight: FontWeight.normal, color: appText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  DottedLine(dashLength: 5, dashGapLength: 5, dashColor: bg,),

                                  SizedBox(
                                    height: 15.0,
                                  ),


                                  Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left:
                                        12.0,
                                        right:12.0,
                                        bottom:
                                        15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        widget.appliedList![index].resume == null ?
                                        GestureDetector(
                                          onTap: () {
                                            Navigator
                                                .push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) {
                                                  return PdfView(widget.appliedList![index].resume!);
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.22,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: appButton,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/file.png",
                                                        height: size.height * 0.035,
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.012,
                                                      ),
                                                      Text(
                                                        "Resume",
                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015,
                                                            fontWeight: FontWeight.bold, color: appHeader),
                                                      ),
                                                    ],
                                                  ))),
                                        ) : Container(),

                                        SizedBox(width: size.width * 0.016,),


                                        GestureDetector(
                                          onTap: () {
                                            _launchWhatsapp(
                                                widget.appliedList![index]
                                                    .contactNo,widget.appliedList![index]);
                                          },
                                          child: Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.22,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/whatsapp.png",
                                                        height: size.height * 0.03,
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.012,
                                                      ),
                                                      Text(
                                                        "Whatsapp",
                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015,
                                                            fontWeight: FontWeight.bold, color: Colors.green),
                                                      ),
                                                    ],
                                                  ))),
                                        ),

                                        SizedBox(width: size.width * 0.016,),

                                        GestureDetector(
                                          onTap: () {
                                            Navigator
                                                .push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) {
                                                  return InvitePage("Veeboss");
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.22,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/star_message.png",
                                                        height: size.height * 0.03,
                                                        color: Colors.blue,
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.012,
                                                      ),
                                                      Text(
                                                        "Invite",
                                                        style: TextStyle(fontFamily: 'railway', fontSize: size.height * 0.015,
                                                            fontWeight: FontWeight.bold, color: Colors.blue),
                                                      ),
                                                    ],
                                                  ))),
                                        ),

                                        SizedBox(width: size.width * 0.016,),

                                        GestureDetector(
                                          onTap: () {
                                            launch(
                                                "tel://${widget.appliedList![index].contactNo}");
                                          },
                                          child: Container(
                                              height: size.height * 0.050,
                                              width: size.width * 0.1,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                /* border: Border.all(
                                                        color: primaryTextColor,
                                                        width: 0.5,
                                                        style: BorderStyle.solid),*/
                                                borderRadius:
                                                BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        size: size.height * 0.03,
                                                        color: appBackground,
                                                      ),
                                                      /* SizedBox(width: size.width*0.012,),
                                                                            Text("Call",style: TextStyle(
                                                                                fontFamily: 'railway',
                                                                                fontSize: size.height * 0.015,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: whiteTextColor),),*/
                                                    ],
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.0,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<void> _launchWhatsapp(String? contactNo, RejectedUser appliedUser,  ) async {
    var whatsapp = contactNo;
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=Dear ${appliedUser.name}\nI am recruiter person from veeboss technology. \n Your profile looks impressive for one of the job");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

}
