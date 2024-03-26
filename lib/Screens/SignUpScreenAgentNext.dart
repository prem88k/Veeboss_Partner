import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeboss_partner/Screens/SignUPOtpPage.dart';
import '../Contants/Colors.dart';
import '../Presentation/common_widgets.dart';
import '../Presentation/rounded_button.dart';
import 'LoginScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

class SignUpScreenAgentNext extends StatefulWidget {
  File image;
  String role;
  String name, password, email, mobile, age, referCode, gender;
  SignUpScreenAgentNext(this.role, this.image, this.name, this.password, this.email, this.mobile, this.age, this.referCode, this.gender);

  @override
  State<SignUpScreenAgentNext> createState() => _SignUpScreenAgentNextState();
}

class _SignUpScreenAgentNextState extends State<SignUpScreenAgentNext> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _aboutCompanyController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _gstNumController = TextEditingController();

  bool isChecked = false;
  bool _obscureText = true;

  File? _companyLogo;
  File? _panCard;
  File? _file;

  Future<void> selectPhoto() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _companyLogo = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }
  String fileName = '';
  File? _image1;

  Future<void> selectFile() async {

    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image1 = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }

  }

  Future<void> selectDoc() async {

    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _panCard = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }

  }

  File? _documentFile;
  Future<void> selectDocumentFile() async {
    try {
      final picker = FilePicker.platform;
      final pickedFile = await picker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final pickedFileSource = File(pickedFile!.files.single.path!);
      fileName = pickedFileSource.path.split('/').last;
      setState(() {
        _documentFile = pickedFileSource;
      });
    } catch (error) {
      print("error: $error");
    }
  }


  final List<String> items = [
    'user',
    'agent',
    'company',
  ];
  String? selectedValue;
  String? gender;
  bool isloading = false;


  late String placeid;
  String googleApikey = "AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo";
  GoogleMapController? mapController; //contrller for Google map
  LatLng? showLocation;
  String location = "Select Leaving from Location..";
  double? pickUpLat;
  double? pickUpLong;

  @override
  void initState() {
    print(widget.role);
    _addressController.addListener(() {
      /*_onChanged();*/
    });
    // TODO: implement initState
    super.initState();
  }

  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          title: Text(
            "",
            style: TextStyle(
                fontFamily: 'railway',
                color: appText,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: appBackground,
          iconTheme: IconThemeData(
              color: appText,
              size: size.height * 0.035 //change your color here
          ),
        ),
        backgroundColor: appBackground,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.012,
                left: size.height * 0.045,
                right: size.height * 0.045,
                bottom: size.height * 0.045),
            alignment: Alignment.topLeft,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Add Company Details",
                            style: TextStyle(
                                fontFamily: 'railway',
                                color: appText,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.035,
                                bottom: size.height * 0.035
                            ),
                            child: GestureDetector(
                              onTap: () {
                                getImage1();
                              },
                              child: _companyLogo == null ? Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.12,
                                  width: size.height * 0.12,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: appText),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo_outlined, color: appText, size: 20,),
                                    SizedBox(height: size.height * 0.008,),
                                    Text(
                                      "Add Logo",
                                      style: TextStyle(
                                          fontFamily: 'railway',
                                          color: appText,
                                          fontSize: size.height * 0.015,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ) :Container(
                                alignment: Alignment.topLeft,
                                height: size.height * 0.12,
                                width: size.height * 0.12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: buttonTextColor,
                                  image: DecorationImage(
                                      image: new FileImage(_companyLogo!),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      //name
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Company Name",
                                style: TextStyle(
                                    fontFamily: 'railway',
                                    color: appText,
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.002,
                          ),
                          TextFieldWidget(
                            controller: _companyNameController,
                            title: "Company Name",
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Website",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            TextFieldWidget(
                              controller: _urlController,
                              title: "Company Website",
                            ),
                          ]
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "City Name",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            TextFieldWidget(
                              controller: _cityController,
                              title: "City Name",
                            ),
                          ]
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Area Name",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            TextFieldWidget(
                              controller: _areaController,
                              title: "City Area",
                            ),
                          ]
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "About Company",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            TextFieldWidget(
                              controller: _aboutCompanyController,
                              title: "About Company",
                            ),
                          ]
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Company Location",
                        style: TextStyle(
                            fontFamily: 'railway',
                            color: appText,
                            fontSize: size.height * 0.015,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color:  borderColors,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height*0.015),
                          child: InkWell(
                              onTap: () async {
                                var place = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: googleApikey,
                                    mode: Mode.overlay,
                                    types: [],
                                    strictbounds: false,
                                    components: [Component(Component.country, 'in')],
                                    //google_map_webservice package
                                    onError: (err){
                                      print(err);
                                    }
                                );
                                if(place != null){
                                  final plist = GoogleMapsPlaces(
                                    apiKey:googleApikey,
                                    apiHeaders: await GoogleApiHeaders().getHeaders(),
                                    //from google_api_headers package
                                  );
                                  placeid = place.placeId ?? "0";
                                  final detail = await plist.getDetailsByPlaceId(placeid);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;
                                  setState(() {
                                    _addressController.text = place.description.toString();
                                    pickUpLat=lat;
                                    pickUpLong=lang;
                                    print(place.description);

                                    var newlatlang = LatLng(lat, lang);
                                    //move map camera to selected place with animation
                                    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                                  });
                                }
                              },
                              child:Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Text(_addressController.text.isEmpty ?
                                  "Select Location":
                                  _addressController.text,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.width * 0.035,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor),),
                                ),
                              )
                          ),
                        ),
                      ),
                  ]
              ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Aadhar Card / PAN Card Number",
                        style: TextStyle(
                            fontFamily: 'railway',
                            color: appText,
                            fontSize: size.height * 0.015,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.002,
                  ),
                      TextFieldWidget(
                        controller: _panCardController,
                        title: "Aadhar Card / PAN Card Number",
                      ),
]
              ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "GST Number",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      color: appText,
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.002,
                            ),
                            TextFieldWidget(
                              controller: _gstNumController,
                              title: "GST Number",
                            ),
                          ]
                      ),



                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: _image1 == null ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: size.height * 0.0,
                                      right: size.height * 0.03),
                                  width: size.width * 0.6,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: borderColors)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined, color: appText,),
                                      SizedBox(width: size.width * 0.020,),
                                      Text(
                                        'Upload GST Certificate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                    ],
                                  ),
                                ) : Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.005,
                                      left: size.height * 0.012,
                                      right: size.height * 0.03),
                                  width: size.width * 0.30,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: new FileImage(_image1!),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  /*Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.normal,
                                        color: appText),
                                  ),*/
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                       Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectDoc();
                                },
                                child: _panCard == null ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      left: size.height * 0.01,
                                      right: size.height * 0.03),
                                  width: size.width * 0.6,
                                  height: size.height * 0.055,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: borderColors)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined, color: appText,),
                                      SizedBox(width: size.width * 0.020,),
                                      Text(
                                        'Upload KYC Document',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'railway',
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.normal,
                                            color: appText),
                                      ),
                                    ],
                                  ),
                                ) : Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.005,
                                      left: size.height * 0.012,
                                      right: size.height * 0.03),
                                  width: size.width * 0.30,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: new FileImage(_panCard!),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  /*Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'railway',
                                        fontSize: size.height * 0.023,
                                        fontWeight: FontWeight.normal,
                                        color: appText),
                                  ),*/
                                ),
                              ),
                            ],
                          )
                        ],
                      ),


                    ],
                  ),
/*
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Agreed to terms and condition",
                      style: TextStyle(
                          fontFamily: 'railway',
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.normal),
                    ),
                    value: isChecked,
                    activeColor: whiteTextColor,
                    checkColor: buttonTextColor,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),*/

                  SizedBox(
                    height: size.height * 0.030,
                  ),
                  isloading
                      ? Center(
                        child: CircularProgressIndicator(
                    backgroundColor: buttonTextColor,
                  ),
                      )
                      : GestureDetector(
                    onTap: () {

                      Register();

                     // checkValidation();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(size.width * 0.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: appButton
                              /*gradient: LinearGradient(
                                  colors: [
                                    Color(0xff2E4B93),
                                    Color(0xff1AA5FF),
                                  ]
                              ),*/
                            ),
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontSize: size.width * 0.04,
                                      color: whiteTextColor),
                                ))),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen(widget.role);
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Already have an Account?",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.normal,
                                  color: appText),
                            ),
                            SizedBox(width: size.width * 0.015,),
                            Text(
                              "LOG IN",
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: appButton),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.025,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                ]),
          ),
        ));
  }

  void checkValidation() {
    if (_companyNameController.text.isEmpty) {
      Message(context, "Enter Company Name");
    } else if (_cityController.text.isEmpty) {
      Message(context, "Enter City");
    }else if (_areaController.text.isEmpty) {
      Message(context, "Enter Area");
    }  else if (_aboutCompanyController.text.isEmpty) {
      Message(context, "Enter About Company");
    }  else if (_urlController.text.isEmpty) {
      Message(context, "Enter Company Website");
    } else if (_panCardController.text.isEmpty) {
      Message(context, "Enter PAN Card Number");
    }  else if (_addressController.text.isEmpty) {
      Message(context, "Enter Location");
    }else if (_image1 == null) {
      Message(context, "Upload Resume");
    } else {
      Register();
    }
  }

  Future<void> Register() async {
    setState(() {
      isloading = true;
    });
    String generateRandomString(int len) {
      var r = Random();
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/register');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);
    request.fields['name'] = widget.name;
    request.fields['refer_code'] = generateRandomString(5);
    request.fields['password'] = widget.password;
    request.fields['email'] = widget.email;
    request.fields['contact_no'] = widget.mobile;
    request.fields['bio'] = "";
    request.fields['age'] = widget.age;
    request.fields['experience'] = "";
    request.fields['role'] =  widget.role;
    request.fields['location'] =  _addressController.text;
    request.fields['position'] =  "";
    request.fields['gender'] = widget.gender.toLowerCase();

    request.fields['company_name'] = _companyNameController.text;
    request.fields['city'] = _cityController.text;
    request.fields['area'] = _areaController.text;
    request.fields['address'] = _addressController.text;
    request.fields['about_company'] = _aboutCompanyController.text;
    request.fields['url'] = _urlController.text;
    request.fields['bio'] = _panCardController.text;
    request.fields['gst_num'] = _gstNumController.text;

    if (widget.referCode != null){
      request.fields['reference_code'] = widget.referCode;
    }

    if(widget.image != null)
    {
      request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            widget.image.path,
          ));
    }


    if(_companyLogo != null)
    {
      request.files.add(
          await http.MultipartFile.fromPath(
            'company_logo',
            _companyLogo!.path,
          ));
    }

    if(_panCard == null){
      Message(context, "Upload Document");
    }
    else {
      request.files.add(
          await http.MultipartFile.fromPath(
            'resume_file',
            _panCard!.path,
            /* File(_documentFile!.path).readAsBytes().asStream(),
              File(_documentFile!.path).lengthSync(),
              filename: _documentFile!.path.split("/").last*/
          ));
    }

    if(_image1 == null){
      Message(context, "Upload Document");
    }
    else {
      request.files.add(
          await http.MultipartFile.fromPath(
            'document_file',
            _image1!.path,
            /* File(_documentFile!.path).readAsBytes().asStream(),
              File(_documentFile!.path).lengthSync(),
              filename: _documentFile!.path.split("/").last*/
          ));
    }

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("Uploaded!");

        int statusCode = response.statusCode;
        print("response::$response");
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          setState(() {
            isloading = false;
          });
          FocusScope.of(context).requestFocus(FocusNode());


          Message(context, "Registration Successfully");
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {

              // todo
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen(widget.role);
                  },
                ),
              );
            });
          });
        });
      } else {
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          var getdata = json.decode(value);
          setState(() {
            isloading = false;
          });
          Message(context,getdata['message']);
        });
        /*setState(() {
          isloading = false;
        });
        Message(context,"Something went Wrong");*/
      }
    });
  }

  getImage1() async {
    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Row(
                children: [
                  Icon(Icons.camera,color: whiteTextColor,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Camera",style: TextStyle(
                    fontFamily: 'Opensans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MaterialButton(
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Row(
                children: [
                  Icon(Icons.picture_in_picture,color: whiteTextColor,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Gallery ",style: TextStyle(
                    fontFamily: 'Opensans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
          source: isCamera! ? ImageSource.camera : ImageSource.gallery);
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _companyLogo = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }

}