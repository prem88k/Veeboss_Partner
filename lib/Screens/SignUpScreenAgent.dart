import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:veeboss_partner/Screens/SignUpScreenAgentNext.dart';
import '../Contants/Colors.dart';
import '../Presentation/common_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LoginScreen.dart';


class SignupAgentPage extends StatefulWidget {
  String role;

  SignupAgentPage(this.role);

  @override
  State<SignupAgentPage> createState() => _SignupAgentPageState();
}

class _SignupAgentPageState extends State<SignupAgentPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aadharCardController = TextEditingController();

  bool isChecked = false;
  bool _obscureText = true;

  File? _image;
  File? _file;


  Future<void> selectPhoto() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final pickedImageFile = File(pickedImage!.path);
      setState(() {
        _image = pickedImageFile;
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
            "Create an account",
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
                            "Add Personal Details",
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
                              child: _image == null ? Container(
                                alignment: Alignment.topLeft,
                                height: size.height * 0.12,
                                width: size.height * 0.12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: buttonTextColor,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/profile.png"
                                      ),
                                      fit: BoxFit.cover
                                  ),
                                )
                              ) :Container(
                                alignment: Alignment.topLeft,
                                height: size.height * 0.12,
                                width: size.height * 0.12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: buttonTextColor,
                                  image: DecorationImage(
                                      image: new FileImage(_image!),
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
                                "Full Name",
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
                            controller: _nameController,
                            title: "Name",
                          ),
                        ],
                      ),

                      SizedBox(
                        height: size.height * 0.010,
                      ),

                      //password
                      Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
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
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 14,
                            color: appText,
                            fontFamily: 'railway',
                          ),
                          decoration: InputDecoration(
                            suffixIcon: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: new Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: appText,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontFamily: 'railway',
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.normal,
                                color: appText),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColors,
                                width: 1.0,

                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: borderColors,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: borderColors, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
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
                        "Email",
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
                        controller: _emailController,
                        title: "Email",
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
                        "Phone Number",
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
                        controller: _mobileController,
                        title: "Phone",
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
                        "Age",
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
                        controller: _ageController,
                        title: "Age",
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
                        "Reference Code",
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
                        controller: _referenceController,
                        title: "Reference Code",
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
                        "Gender",
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
                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor:appButton,
                            disabledColor: appText
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                activeColor: appButton,
                                title: Text("Male", style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.normal,
                                    color: appText)),
                                value: "male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child:  RadioListTile(
                                activeColor: appButton,
                                title: Text("Female", style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.normal,
                                    color: appText)),
                                value: "female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                ]
              ),
                    ],
                  ),

                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  isloading
                      ? CircularProgressIndicator(
                    backgroundColor: buttonTextColor,
                  )
                      : GestureDetector(
                    onTap: () {
                     /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreenAgentNext(widget.role, _image!=null ? _image! : File(""), _nameController.text, _passwordController.text,
                                _emailController.text, _mobileController.text, _ageController.text, _referenceController.text, gender.toString()
                            );
                          },
                        ),
                      );*/
                     checkValidation();
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
                            width: size.width * 0.4,
                            height: size.height * 0.06,
                            child: Center(
                                child: Text(
                                  "Next",
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

                ]),
          ),
        ));
  }

  void checkValidation() {
    bool contactValid =
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_mobileController.text);

    if (_nameController.text.isEmpty) {
      Message(context, "Enter Name");
    } else if (_passwordController.text.isEmpty) {
      Message(context, "Enter Password");
    }else if (_emailController.text.isEmpty) {
      Message(context, "Enter Email");
    } else if (!contactValid) {
      Message(context, "Enter valid Contact Number");
    } else if (_mobileController.text.isEmpty) {
      Message(context, "Enter Contact Number");
    }  else if (_ageController.text.isEmpty) {
      Message(context, "Enter Age");
    }  else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignUpScreenAgentNext(widget.role, _image!=null ? _image! : File(""), _nameController.text, _passwordController.text,
                _emailController.text, _mobileController.text, _ageController.text, _referenceController.text, gender.toString()
            );
          },
        ),
      );
    }
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
        _image = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }

}
