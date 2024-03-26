import 'package:flutter/material.dart';
import '../Contants/Colors.dart';


class AboutUs extends StatefulWidget {
  String title;
  AboutUs( this.title);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AboutUs>  {
  bool isLoading=true;
  /*DarkThemeProvider themeChange;
  ColorsInf colorsInf;*/


  List<String> jobSeaker = [
    "A user-friendly platform to explore a wide range of job opportunities in the non-IT tech sector",
    "A smart matching system that connects you with the most suitable employers based on your skills, experience, and interests",
    "A dedicated support team that helps you with resume writing, interview preparation, salary negotiation, and career development",
    "A mobile app that allows you to access our platform anytime, anywhere"];

  List<String> jobEmp = [
    "A comprehensive database of qualified and verified candidates in the non-IT tech sector",
    "A flexible and cost-effective recruitment solution that allows you to post jobs, manage applications, schedule interviews, and hire candidates with ease",
    "A professional team that assists you with sourcing, screening, shortlisting, and evaluating candidates",
    "A web portal that enables you to track and manage your recruitment process online"];

  List<String> jobPort = [
    "Creating a website and a mobile app for our platform, using the latest technology and design principles, to provide a user-friendly and engaging experience for our users",
    "Developing a smart matching system that uses data science and artificial intelligence to connect job seekers with the most suitable employers based on their skills, experience, and interests",
    "Providing valuable career insights and guidance to our job seekers, using real-life examples and case studies from the non-IT tech sector",
    "Offering advanced recruitment tools and services to our employers, such as resume screening, candidate assessment, interview scheduling, and hiring analytics"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   /* themeChange = Provider.of<DarkThemeProvider>(context);
    colorsInf = getColor(context);*/
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: appText,
            size: size.height * 0.035 //change your color here
        ),
        centerTitle: true,
        backgroundColor: appBackground,
        title: Text(
          widget.title,
          style: TextStyle(
              fontFamily: 'railway',
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.025,
              color: appText),
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(size.height*0.03),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                    fit: BoxFit.fill,
                    height: size.height * 0.15,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.035,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text("VEEBOSS TECHNOLOGY PVT LTD",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.04,
                      color: appHeader
                  ),),
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("About Us",
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

                Text(
                  "At VEEBOSS TECHNOLOGY PVT LTD, we believe in the power of connecting talent with opportunity. We are a recruitment agency startup that specializes in non-IT tech recruitment. We help talented professionals find their dream jobs in emerging sectors such as biotechnology, nanotechnology, clean energy, and more. We also help innovative companies find, attract, and retain the best talent in the market.",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText
                  ),),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Our Story",
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
                Text("We started our journey in 2020, with a vision to bridge the gap between talent and opportunity in "
                    "the non-IT tech sector. We realized that there was a huge demand for skilled professionals in this "
                    "sector, but there was a lack of reliable and efficient platforms to connect them with the right "
                    "employers. We decided to create our own platform, using cutting-edge technology and data-driven "
                    "strategies, to provide a seamless and satisfying experience for both job seekers and employers.",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText
                  ),),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Our Mission",
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

            Text("Our mission is to empower people and organizations to achieve their full potential in the non-IT tech "
                "sector. We believe that this sector has immense potential to create positive impact on the world, and "
                "we want to be a part of it. We are committed to providing high-quality services, personalized "
                "guidance, and valuable insights to our clients and partners.",
              style: TextStyle(
                  fontFamily: 'railway',
                  fontWeight: FontWeight.normal,
                  fontSize: size.width * 0.03,
                  color: appText
              ),),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Our Services",
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

                Text(
                     "We offer a range of services to suit the needs and preferences of our clients and partners. These include:",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText
                  ),
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("For Job Seekers",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.035,
                        color: appHeader
                    ),),
                ),

                SizedBox(
                  height: size.height * 0.010,
                ),

                Column(
                  children: jobSeaker.map((strone){
                   return Row(
                        children:[
                          Text("\u2022",  style: TextStyle(
                              fontFamily: 'railway',
                              fontWeight: FontWeight.normal,
                              fontSize: size.width * 0.07,
                              color: appText
                          ),), //bullet text
                          SizedBox(width: 10,), //space between bullet and text
                          Expanded(
                            child:Text(strone,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width * 0.03,
                                  color: appText
                              ),
                            ), //text
                          )
                        ]
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("For Employers",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.035,
                        color: appHeader
                    ),),
                ),

                SizedBox(
                  height: size.height * 0.010,
                ),

                Column(
                  children: jobEmp.map((str){
                    return Row(
                        children:[
                          Text("\u2022",  style: TextStyle(
                              fontFamily: 'railway',
                              fontWeight: FontWeight.normal,
                              fontSize: size.width * 0.07,
                              color: appText
                          ),), //bullet text
                          SizedBox(width: 10,), //space between bullet and text
                          Expanded(
                            child:Text(str,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width * 0.03,
                                  color: appText
                              ),
                            ), //text
                          )
                        ]
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: size.height * 0.015,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Our Portfolio",
                    style: TextStyle(
                        fontFamily: 'railway',
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.035,
                        color: appHeader
                    ),),
                ),

                SizedBox(
                  height: size.height * 0.010,
                ),

                Text(
                  "We are proud to showcase some of our portfolio that demonstrate our expertise and value in the non-IT tech sector. These include:",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText
                  ),
                ),

                SizedBox(
                  height: size.height * 0.010,
                ),

                Column(
                  children: jobPort.map((port){
                    return Row(
                        children:[
                          Text("\u2022",  style: TextStyle(
                              fontFamily: 'railway',
                              fontWeight: FontWeight.normal,
                              fontSize: size.width * 0.07,
                              color: appText
                          ),), //bullet text
                          SizedBox(width: 10,), //space between bullet and text
                          Expanded(
                            child:Text(port,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: size.width * 0.03,
                                  color: appText
                              ),
                            ), //text
                          )
                        ]
                    );
                  }).toList(),
                ),

                SizedBox(
                  height: size.height * 0.020,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Join Us on the Journey",
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

                Text("Whether you are a job seeker looking for your dream career path or an employer seeking exceptional "
                    "talent to drive your organization’s success, we invite you to join us on this exciting journey. Together, "
                    "we can create a brighter future for individuals and businesses alike. Thank you for choosing VEEBOSS "
                    "TECHNOLOGY PVT LTD as your trusted partner in the world of recruitment. We look forward to "
                    "serving you and helping you reach new heights in your career or talent acquisition endeavours.",
                  style: TextStyle(
                      fontFamily: 'railway',
                      fontWeight: FontWeight.normal,
                      fontSize: size.width * 0.03,
                      color: appText
                  ),),

                SizedBox(
                  height: size.height * 0.020,
                ),


              ],
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

