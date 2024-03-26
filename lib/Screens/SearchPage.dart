import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../Contants/Colors.dart';
import '../Models/Employee/GetAllSearchJobPosts.dart';
import '../Models/Employee/MyJobs.dart';
import '../ProfileJobDetails.dart';
import 'Employee/ApploedJObsPage.dart';
import 'Employee/VoiceNoteScreen.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late GetAllSearchJobPosts getAllSearchJobPosts;
  List<SearchJobList> searchJobListData = [];

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];

  bool jobsLoading = false;

  final TextEditingController _searchController = TextEditingController();

  get index => 0;

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        bottomOpacity: 0,
        shape: Border(
            bottom: BorderSide(
                color: borderColors,
                width: 0.5
            )
        ),

        elevation: 1,
        title: Text(
          "Search Page",
          style: TextStyle(
              fontFamily: 'railway',
              color: appText,
              fontSize: size.height * 0.025,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: appBackground,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.035,
                        vertical: size.height * 0.01),
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (text){
                        if (text.length > 0) {
                          FetchProducts(text);
                        }
                      },
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.normal,
                          color: appText),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            fontFamily: 'railway',
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.normal,
                            color: appText),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryTextColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: primaryTextColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  jobsLoading
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      :  searchJobListData.length == 0 ?
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: size.height * 0.4),
                          child: Text(
                            "Jobs Not Found",
                            style: TextStyle(
                                fontFamily: 'railway',
                                color: appText,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          )))
                      : Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                    primary: false,
                    //   scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: searchJobListData.length,
                    itemBuilder: (BuildContext context, int index) {
                          //  status = "pending";
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, bottom: 5.0, left: 0.0, right: 0.0),
                            child: GestureDetector(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return IntroductionScreen();
                                    },
                                  ),
                                );*/
                              },
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: size.width,
                                      child: Card(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0.0)),
                                        elevation: 0.0,
                                        child: Container(
                                          width: size.width,
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.00),
                                          decoration: new BoxDecoration(
                                            color: appBackground,
                                            shape: BoxShape.rectangle,
                                            border: Border.all(color: bookingCardColor),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.0,
                                                offset: const Offset(0.0, 0.0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            // To make the card compact
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.020,
                                                    top: 10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EmployerProfile(jobListData[index].userId);
                                      },
                                    ),
                                  );*/
                                                            },
                                                            child: searchJobListData[index]
                                                                .profilePhoto == null
                                                                ? Container(
                                                                alignment: Alignment
                                                                    .topCenter,
                                                                height: size.height *
                                                                    0.080,
                                                                width: size.height *
                                                                    0.080,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(100),
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/images/profile.png"),
                                                                        fit: BoxFit.fill
                                                                    )
                                                                  )
                                                               ) : Container(
                                                                alignment: Alignment
                                                                    .topCenter,
                                                                height: size.height *
                                                                    0.080,
                                                                width: size.height *
                                                                    0.080,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(100),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            searchJobListData[index].profilePhoto
                                                                                .toString()),
                                                                        fit: BoxFit.fill
                                                                    )
                                                                )
                                                            )
                                                        ),
                                                        SizedBox(
                                                          width: size.width * 0.030,),
                                                        Container(
                                                          width: size.width * 0.65,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Container(
                                                                    width: size.width *
                                                                        0.6,
                                                                    child: Text(
                                                                      //userList[index],
                                                                      searchJobListData[index].post!,
                                                                      style: TextStyle(
                                                                          fontFamily: 'railway',
                                                                          fontSize: size
                                                                              .width *
                                                                              0.036,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: appHeader),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: size.height *
                                                                    0.006,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [

                                                                  Text(
                                                                    'Vacancy:- ',
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size
                                                                            .width *
                                                                            0.032,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: appText),
                                                                  ),
                                                                  SizedBox(
                                                                    width: size.width *
                                                                        0.0055,),

                                                                  Text(
                                                                    searchJobListData[index]
                                                                        .vacancy
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily: 'railway',
                                                                        fontSize: size
                                                                            .height *
                                                                            0.020,
                                                                        fontWeight: FontWeight.normal,
                                                                        color: appText),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return ProfileJobDetails(
                                                                  jobListData[index]);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.topRight,
                                                          padding: EdgeInsets.only(
                                                              right: size.width *
                                                                  0.012),
                                                          child: Icon(
                                                            Icons.visibility_outlined,
                                                            color: appText,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.015,),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    DescriptionTextWidget(
                                                      text: searchJobListData[index]
                                                          .description.toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.010,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  searchJobListData[index].file == null
                                                      ? Container()
                                                      : Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Container(
                                                      height: size.height * 0.35,
                                                      width: size.width * 0.90,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              searchJobListData[index].file!
                                                                  .mainImageUrl
                                                                  .toString()),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: size.height * 0.005,),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Divider(
                                                  thickness: 0.5,
                                                  color: primaryTextColor,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if(  searchJobListData[index].isApply !=
                                                            "is_apply" ){
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) {
                                                                return VoiceNote(
                                                                    searchJobListData[index].id!
                                                                        .toInt());
                                                              },
                                                            ),
                                                          );
                                                        }
                                                        // _showDialog(context);
                                                        //    ApplyJobs(jobListData[index].id!.toInt());
                                                      },
                                                      child: Column(
                                                        children: [
                                                          searchJobListData[index].isApply == "is_apply" ?
                                                          Container(
                                                            // padding: EdgeInsets.only(right: 8.0),
                                                            child: Image.asset(
                                                              "assets/images/apply_fill.png",
                                                              color: appHeader,
                                                              height: size.height *
                                                                  0.025,),) :
                                                          Container(
                                                            child: Image.asset(
                                                              "assets/images/apply.png",
                                                              color: appText,
                                                              height: size.height *
                                                                  0.025,),),
                                                          SizedBox(
                                                            height: size.height * 0.002,
                                                          ),
                                                          Container(
                                                            child: Text('Apply',
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.width *
                                                                      0.030,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: appText),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                       SaveJobs(searchJobListData[index].id!.toInt());
                                                      },
                                                      child: Column(
                                                        children: [
                                                          searchJobListData[index].isSave ==
                                                              "is_save" ?
                                                          Container(
                                                            // padding: EdgeInsets.only(right: 8.0),
                                                            child: Image.asset(
                                                              "assets/images/save_fill.png",
                                                              color: appHeader,
                                                              height: size.height *
                                                                  0.025,
                                                            ),) : Container(
                                                            // padding: EdgeInsets.only(right: 8.0),
                                                            child: Image.asset(
                                                              "assets/images/save.png",
                                                              color: appText,
                                                              height: size.height *
                                                                  0.025,
                                                            ),),
                                                          SizedBox(
                                                            height: size.height * 0.002,
                                                          ),
                                                          Container(
                                                            child: Text('Save',
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.width *
                                                                      0.030,
                                                                  fontWeight: FontWeight
                                                                      .normal,
                                                                  color: appText),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                     _onShare(context);
                                                        // Share.share(jobListData[index].description!, subject: 'Welcome Message');
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            // padding: EdgeInsets.only(right: 8.0),
                                                            child: Image.asset(
                                                              "assets/images/send.png",
                                                              color: appText,
                                                              height: size.height *
                                                                  0.025,),),
                                                          SizedBox(
                                                            height: size.height * 0.002,
                                                          ),
                                                          Container(
                                                            child: Text('Share',
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.width *
                                                                      0.030,
                                                                  fontWeight: FontWeight
                                                                      .normal,
                                                                  color: appText),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                    },
                  ),
                        ),
                      ),
                ],
              ),
            ),
    );
  }
  Future<void> _onShare(BuildContext context) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        " ${searchJobListData[index].description!}, ${searchJobListData[index].post!},"
            "${searchJobListData[index].vacancy.toString()}, "
            "${searchJobListData[index].file!.mainImageUrl.toString()}" ,
        subject: 'Welcome Message',
        sharePositionOrigin:  Rect.fromLTWH(15, 50, 15, 50)
    );
  }

  Future<void> FetchProducts(String search) async {
    searchJobListData.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    Map<String, dynamic> body = {
      'name': search,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/searchpost',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var getdata = json.decode(response.body);

    print("BookedHistory::$responseBody");
    if (statusCode == 200) {
     // if (getdata["success"]) {
        setState(() {
          jobsLoading = false;
        });
        getAllSearchJobPosts = GetAllSearchJobPosts.fromJson(jsonDecode(responseBody));
        searchJobListData.addAll(getAllSearchJobPosts.data!);
      } else {
        setState(() {
          jobsLoading = false;
        });
      }
    }

  Future<void> SaveJobs(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobsLoading = true;
    });
    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/job/save',
    );
    final headers = {
      'x-session-token': prefs.getString('sessionToken')!,
    };
    Map<String, dynamic> body = {
      'job_id': id.toString(),
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
    print("response::$responseBody");
    if (statusCode == 200) {
      setState(() {
        jobsLoading = false;
      });
      prefs.setBool("isLogging", true);

      FocusScope.of(context).requestFocus(FocusNode());
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _showSaveJobDialog(context);
        });
      });
    } else {
      setState(() {
        jobsLoading = false;
      });
    }
  }

  _showSaveJobDialog(BuildContext ctx) {
    Size size = MediaQuery
        .of(context)
        .size;
    showDialog(
      builder: (context) =>
          SimpleDialog(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                color: Colors.white,
                child: Image.asset(
                  "assets/images/checklist.png",
                  height: 110.0,
                ),
              ),
              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Are you want to applied this job ?",
                      style: TextStyle(
                          fontFamily: "railway",
                          fontWeight: FontWeight.w700,
                          color: appText,
                          letterSpacing: 0.5,
                          fontSize: 15.0),
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      jobsLoading
                          ? CircularProgressIndicator(
                        backgroundColor: buttonTextColor,
                      )
                          : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          //   AddToCart(widget.item.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(size.width * 0.01),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: appButton,
                                  /*boxShadow: [
                                    BoxShadow(
                                        color: buttonTextColor,
                                        spreadRadius: 1),
                                  ],*/
                                ),
                                width: size.width * 0.25,
                                height: size.height * 0.05,
                                child: Center(
                                    child: Text(
                                      "Save Jobs",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          fontSize: size.width * 0.04,
                                          color: appText),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )


              /* Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                child: Text(
                  "Thank you for Applying for job in this app",
                  style: TextStyle(
                      fontFamily: "railway",
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      fontSize: 17.0,
                      color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
              )),*/
            ],
          ), context: ctx,
      barrierDismissible: true,
    );
  }

}

