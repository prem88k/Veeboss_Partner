import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Contants/Colors.dart';
import '../../Models/Employee/GetBannerData.dart';
import '../../Models/Employee/GetCategoryData.dart';
import '../../Models/Employee/MyJobs.dart';
import '../../Presentation/PagerState.dart';
import '../../ProfileJobDetails.dart';
import '../Employee/CategorywiseJob.dart';
import '../Employee/VoiceNoteScreen.dart';

class EmployeeHomeScreen extends StatefulWidget {
  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen>
    with TickerProviderStateMixin {
  late PageController controller1, controller2;
  final StreamController<PagerState> pagerStreamController =
      StreamController<PagerState>.broadcast();

  late GetCategoryData getCategoryData;
  List<CategoryList> categoryList = [];

  late GetBannerData getBannerData;
  List<BannerList> bannerList = [];

  late GetAllMyJobPosts getAllMyJobPosts;
  List<jobList> jobListData = [];
  bool isLoading = false;
  bool jobsLoading = false;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  bool flag = true;
  bool readMore = false;

  int _currentPage = 0;
  int _indexPage = 0;
  late Timer _timer, _timerOffer;
  int index = 0;

  final bannerListPage = [
    'assets/images/trend1.jpg',
    'assets/images/trend2.jpg',
    'assets/images/trend3.png',
  ];


  @override
  void initState() {
    controller1 = PageController(initialPage: 0, viewportFraction: 1.1);
    controller2 = PageController(initialPage: 0, viewportFraction: 1.1);
    getJobsData("job/get");
    getCategory();
    getBanner();

    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < bannerList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      controller1.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });

    _timerOffer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_indexPage < bannerListPage.length) {
        _indexPage++;
      } else {
        _indexPage = 0;
      }

      controller2.animateToPage(
        _indexPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      backgroundColor: appBackground,
      key: _scaffoldKey,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: buttonTextColor,
            ))
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //banner
                    Container(
                        height: size.height * 0.2,
                        width: size.width,
                        child: PageView.builder(
                          itemCount: bannerList.length,
                          pageSnapping: false,
                          controller: controller1,
                          onPageChanged: (int value) {
                            controller1.addListener(() {
                              pagerStreamController
                                  .add(PagerState(controller1.page!.toInt()));
                            });
                          },
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      child: Container(
                                        width: size.height * 0.60,
                                        height: size.height * 0.16,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                bannerList[index].images!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ); // you forgot this
                          },
                        )),

                    Padding(
                      padding: EdgeInsets.only(
                          left: size.height * 0.035, right: size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: appText),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    // category list
                    Column(
                      children: [
                        Container(
                          child: SizedBox(
                            height: size.height * 0.28,
                            child: GridView.builder(
                              itemCount: categoryList.length,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 0,
                                      left: size.height * 0.02,
                                      right: size.height * 0.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return CategoryWiseJob(
                                                    categoryList[index].id,categoryList[index].name);
                                              },
                                            ),
                                          );
                                          /*  getJobsData("cetegory-wise-job",
                                              categoryList[index].id);*/
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(2, 2, 2, 0),
                                          height: size.height * 0.085,
                                          width: size.width * 0.22,
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            categoryList[index]
                                                                .images
                                                                .toString(),
                                                          ),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  )),
                                                ],
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.010,
                                      ),
                                      Container(
                                        width: size.width * 0.16,
                                        alignment: Alignment.center,
                                        child: categoryList[index].name == 0
                                            ? Center(
                                                child: Text(
                                                "-",
                                                style: TextStyle(
                                                    fontFamily: 'railway',
                                                    color: appText,
                                                    fontSize:
                                                        size.width * 0.012,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))
                                            : Text(
                                                categoryList[index].name!,
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                                //categoryList[index],
                                                style: TextStyle(
                                                    color: appText,
                                                    fontSize:
                                                        size.height * 0.012,
                                                    fontFamily: 'railway'),
                                              ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.height * 0.025,
                          right: size.height * 0.025),
                      child: Row(
                        children: [
                          Text(
                            'Trendings & Offeres',
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.bold,
                                color: appText),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Divider(
                      height: 0.5,
                      color: primaryTextColor,
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Container(
                        height: size.height * 0.070,
                        width: size.width,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bannerListPage.length,
                          pageSnapping: false,
                          controller: controller2,
                          onPageChanged: (int value) {
                            controller2.addListener(() {
                              pagerStreamController
                                  .add(PagerState(controller2.page!.toInt()));
                            });
                          },
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(0.0),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      child: Container(
                                        width: size.height * 0.60,
                                        height: size.height * 0.070,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                bannerListPage[index]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ); // you forgot this
                          },
                        )),
                    ]
                ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Divider(
                      height: 0.5,
                      color: primaryTextColor,
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.height * 0.025,
                          right: size.height * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Suggestions For You',
                            style: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.022,
                                fontWeight: FontWeight.bold,
                                color: appText),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    // recent job list
                    jobListData.length == 0
                        ? Center(
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
                        : Column(
                            children: [
                              Container(
                                child: ListView.builder(
                                  primary: false,
                                  //  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jobListData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //  status = "pending";
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.0,
                                          bottom: 5.0,
                                          left: 0.02,
                                          right: 0.02),
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
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              Container(
                                                color: appBackground,
                                                padding: EdgeInsets.only(
                                                    left: size.height * 0.01,
                                                    right: size.height * 0.01),
                                                width: size.width,
                                                child: Container(
                                                  width: size.width,
                                                  padding: EdgeInsets.only(
                                                      left: size.width * 0.00),
                                                  decoration: new BoxDecoration(
                                                    color: appBackground,
                                                    border: Border.all(
                                                        color: borderColors,
                                                        width: 0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 0.0,
                                                        offset: const Offset(
                                                            0.0, 0.0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    // To make the card compact
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.020,
                                                                top: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
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
                                                                    child: jobListData[index].file ==
                                                                            null
                                                                        ? Container(
                                                                            alignment: Alignment
                                                                                .topCenter,
                                                                            height: size.height *
                                                                                0.080,
                                                                            width: size.height *
                                                                                0.080,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.fill)))
                                                                        : Container(alignment: Alignment.topCenter, height: size.height * 0.080, width: size.height * 0.080,
                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                                                                            image: DecorationImage(image: NetworkImage(jobListData[index]
                                                                                .file!
                                                                                .mainImageUrl
                                                                                .toString()), fit: BoxFit.cover)))),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.030,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      size.width *
                                                                          0.6,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                size.width * 0.6,
                                                                            child:
                                                                                Text(
                                                                              //userList[index],
                                                                              jobListData[index].post!,
                                                                              style: TextStyle(fontFamily: 'railway', fontSize: size.width * 0.036,
                                                                                  fontWeight: FontWeight.bold, color: appButton),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: size.height *
                                                                            0.006,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Vacancy: ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'railway',
                                                                                fontSize: size.width * 0.028,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: appText),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                size.width * 0.0055,
                                                                          ),
                                                                          Text(
                                                                            jobListData[index].vacancy.toString(),
                                                                            style: TextStyle(
                                                                                fontFamily: 'railway',
                                                                                fontSize: size.width * 0.028,
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
                                                                    builder:
                                                                        (context) {
                                                                      return ProfileJobDetails(
                                                                          jobListData[
                                                                              index]);
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  padding: EdgeInsets.only(
                                                                      right: size
                                                                              .width *
                                                                          0.012),
                                                                  child: Icon(
                                                                    Icons
                                                                        .visibility_outlined,
                                                                    color:
                                                                    appText,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height:
                                                            size.height * 0.015,
                                                      ),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                right: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                          Icon(Icons.backpack,
                                                          color: appText, size: size.height * 0.025 ,),
                                                            SizedBox(
                                                              width:
                                                              size.width * 0.025,
                                                            ),
                                                            DescriptionTextWidget(
                                                              text: jobListData[index].companyInfo == null ?
                                                              "-" :
                                                              jobListData[index].companyInfo!,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        size.height * 0.015,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 12.0,
                                                            right: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Icon(Icons.location_on_outlined,
                                                              color: appText, size: size.height * 0.025 ,),
                                                            SizedBox(
                                                              width:
                                                              size.width * 0.025,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                               /* Text(
                                                                  jobListData[index].city == null ?
                                                                  "-" :
                                                                  jobListData[index].city! + " , ",
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',
                                                                      fontSize: size.height * 0.015,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: appText),
                                                                ),*/
                                                                Text(
                                                                  jobListData[index].location == null ?
                                                                  "-" :
                                                                  jobListData[index].location!,
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',
                                                                      fontSize: size.height * 0.015,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: appText),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                        size.height * 0.015,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left: 15.0,
                                                            right: 8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("₹",
                                                              style: TextStyle(
                                                                  fontFamily: 'railway',
                                                                  fontSize: size.height * 0.025,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: appText)),
                                                            SizedBox(
                                                              width:
                                                              size.width * 0.025,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  jobListData[index].salary == null ?
                                                                  "-" : "${jobListData[index].salary!} - " ,
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',
                                                                      fontSize: size.height * 0.020,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: appText),
                                                                ),
                                                                Text(
                                                                  jobListData[index].salaryEnd == null ?
                                                                  "-" : "₹ ${jobListData[index].salaryEnd!} salary /month" ,
                                                                  style: TextStyle(
                                                                      fontFamily: 'railway',

                                                                      fontSize: size.height * 0.020,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: appText),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.010,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          jobListData[index].file == null
                                                              ? Container()
                                                              : Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        size.height *
                                                                            0.3,
                                                                    width: size
                                                                            .width *
                                                                        0.85,
                                                                        child: Image.network(jobListData[index]
                                                                            .file!
                                                                            .mainImageUrl
                                                                            .toString(), width: size.width),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.010,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0,
                                                                right: 8.0),
                                                        child: Divider(
                                                          thickness: 0.1,
                                                          color:
                                                              primaryTextColor,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (jobListData[
                                                                            index]
                                                                        .isApply !=
                                                                    "is_apply") {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return VoiceNote(jobListData[index]
                                                                            .id!
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
                                                                  jobListData[index]
                                                                              .isApply ==
                                                                          "is_apply"
                                                                      ? Container(
                                                                          // padding: EdgeInsets.only(right: 8.0),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/apply_fill.png",
                                                                            color:
                                                                            appButton,
                                                                            height:
                                                                                size.height * 0.025,
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/apply.png",
                                                                            height:
                                                                                size.height * 0.025,
                                                                            color:
                                                                            appText,
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.002,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      'Apply',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'railway',
                                                                          fontSize: size.width *
                                                                              0.030,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              primaryTextColor),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                SaveJobs(
                                                                    jobListData[
                                                                            index]
                                                                        .id!
                                                                        .toInt());
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  jobListData[index]
                                                                              .isSave ==
                                                                          "is_save"
                                                                      ? Container(
                                                                          // padding: EdgeInsets.only(right: 8.0),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/save_fill.png",
                                                                            color:
                                                                            appButton,
                                                                            height:
                                                                                size.height * 0.023,
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          // padding: EdgeInsets.only(right: 8.0),
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/save.png",
                                                                            height:
                                                                                size.height * 0.023,
                                                                            color:
                                                                            appText,
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.002,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      'Save',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'railway',
                                                                          fontSize: size.width *
                                                                              0.030,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                          appText),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                _onShare(
                                                                    context);
                                                                // Share.share(jobListData[index].description!, subject: 'Welcome Message');
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    // padding: EdgeInsets.only(right: 8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/images/send.png",
                                                                      height: size
                                                                              .height *
                                                                          0.023,
                                                                      color:appText,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.002,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      'Share',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'railway',
                                                                          fontSize: size.width *
                                                                              0.030,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                          appText),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _onShare(BuildContext context) async {
    // RenderBox? renderBox = context.findRenderObject() as RenderBox;
    await Share.shareWithResult(
        " ${jobListData[index].description!}, ${jobListData[index].post!},"
        "${jobListData[index].vacancy.toString()}, "
        "${jobListData[index].file!.mainImageUrl.toString()}",
        subject: 'Welcome Message',
        sharePositionOrigin: Rect.fromLTWH(15, 50, 15, 50));
  }

  Future<void> getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/category',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getCategoryImages::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getCategoryData = GetCategoryData.fromJson(jsonDecode(responseBody));
      categoryList.addAll(getCategoryData.data!);
    }
  }

  Future<void> getBanner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/banner',
    );
    final encoding = Encoding.getByName('utf-8');

    Response response = await get(
      uri,
      headers: headers,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("getBannerImages::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getBannerData = GetBannerData.fromJson(jsonDecode(responseBody));
      bannerList.addAll(getBannerData.data!);
    }
  }

  Future<void> getJobsData(String endPoint, [int? id]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    final headers = {'x-session-token': prefs.getString('sessionToken')!};

    var uri = Uri.https(
      'yourang.shop',
      '/veeboss/public/api/v1/$endPoint',
    );
    final encoding = Encoding.getByName('utf-8');

    Map<String, dynamic> body = {
      'cetegory_id': id.toString(),
    };
    int statusCode;
    String responseBody;

    if (endPoint == "cetegory-wise-job") {
      print("cetegory-wise");
      Response response = await post(uri, headers: headers, body: body);
      statusCode = response.statusCode;
      responseBody = response.body;
    } else {
      Response response = await get(
        uri,
        headers: headers,
      );
      statusCode = response.statusCode;
      responseBody = response.body;
    }

    print("getUserPostJobs::$responseBody");
    if (statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      getAllMyJobPosts = GetAllMyJobPosts.fromJson(jsonDecode(responseBody));
      jobListData.addAll(getAllMyJobPosts.data!);
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
    Size size = MediaQuery.of(context).size;
    showDialog(
      builder: (context) => SimpleDialog(
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
              "Are you want to save this job ?",
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
                  isLoading
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
                                   /* boxShadow: [
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

        ],
      ),
      context: ctx,
      barrierDismissible: true,
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
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
          ? Container(
              width: size.width * 0.68,
              child: new Text(
                firstHalf,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'railway',
                    fontSize: size.height * 0.015,
                    color: appButton),
              ),
            )
          : Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: size.width * 0.68,
                      child: Text(
                        flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                        style: TextStyle(
                            fontSize: size.height * 0.015,
                            fontFamily: 'railway',
                            color: appButton),
                      )),
                  InkWell(
                    child: Text(
                      flag ? "Read More" : "Read Less",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: appHeader,
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'railway',
                      ),
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
    );
  }
}
