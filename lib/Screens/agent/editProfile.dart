import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import '../../Contants/Colors.dart';
import '../../Models/Agent/ProfileData.dart';
import '../../Presentation/common_widgets.dart';
import '../../Presentation/rounded_button.dart';
import '../Employee/BottomNavigationBarEmploye.dart';
import '../Employer/BottomNavigationBar.dart';
import '../Vendor/BottomNavigationBarVendor.dart';
import 'BottomNavigationBar.dart';


class editProfile extends StatefulWidget {
  GetProfileInformation getProfileInformation;
editProfile (this.getProfileInformation);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  late String _radioValue;
  late String choice;
  TextEditingController _bioController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String? gender;

  final GlobalKey<ScaffoldState> _dateOfBirthController =
      new GlobalKey<ScaffoldState>();
  String? profile_image;
  File ?_image;
  ImagePicker picker = ImagePicker();
  bool isloading = false;
  late String emailId;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late GetProfileInformation getProfileInformation;
  File? _file;
  String fileName = '';

  Future<void> selectFile() async {
    try {
      final picker = FilePicker.platform;
      final pickedFile = await picker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final pickedFileSource = File(pickedFile!.files.single.path!);
      fileName = pickedFileSource.path.split('/').last;
      setState(() {
        _file = pickedFileSource;
      });
    } catch (error) {
      print("error: $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _radioValue = "male";
    super.initState();
    getProfileData();
  }


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
  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'male':
          choice = value;
          break;
        case 'female':
          choice = value;
          break;
        default:
          choice = "null";
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackground,
        key: _scaffoldKey,
        appBar: AppBar(
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
          backgroundColor: appBackground,
               centerTitle: true,
          title: Text("Edit Profile",
              style: TextStyle(fontFamily: "railway", color: appText, fontSize: 18)),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.017,
                    left: size.height * 0.035,
                    right: size.height * 0.035,
                 //   bottom: size.height * 0.045
                ),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Edit Personal Details",
                            style: TextStyle(
                                fontFamily: 'railway',
                                color: appButton,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      Padding(
                        padding:EdgeInsets.only(top: size.height * 0.025, bottom:size.height * 0.025 ),
                        child:Center(
                          child:_image != null ? Container(
                            alignment: Alignment.topCenter,
                            height: size.height * 0.15,
                            width: size.height * 0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: FileImage (_image!),
                                    fit: BoxFit.fill
                                )
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  getImage1();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(05),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: buttonTextColor),
                                      color: Colors.white,
                                      borderRadius:BorderRadius.circular(100)
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: appButton,
                                  ),
                                ),
                              ),
                            ),
                          ): profile_image == "" ? Container(
                              alignment: Alignment.topCenter,
                            height: size.height * 0.15,
                            width: size.height * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: AssetImage ("assets/images/profile_photo.jpg"),
                                      fit: BoxFit.fill
                                  )
                              ),
                            child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                getImage1();
                              },
                              child: Container(
                                padding: EdgeInsets.all(05),
                                decoration: BoxDecoration(
                                    border: Border.all(color: buttonTextColor),
                                    color: Colors.white,
                                    borderRadius:BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: appBackground,
                                ),
                              ),
                            ),
                          ),
                          ): Container(
                            alignment: Alignment.center,
                            height: size.height * 0.15,
                            width: size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: buttonTextColor,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      profile_image.toString(),
                                  ),
                                  fit: BoxFit.cover
                              ),
                            ),
                            child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                getImage1();
                              },
                              child: Container(
                                padding: EdgeInsets.all(05),
                                decoration: BoxDecoration(
                                    border: Border.all(color: buttonTextColor),
                                    color: appButton,
                                    borderRadius:BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: appBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFieldWidget(
                          controller: _userNameController,
                          title: "Username",
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFieldWidget(
                          controller: _emailController,
                          title: "Email",
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFieldWidget(
                          controller: _locationController,
                          title: "Location",
                        ),),

                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TextFieldWidget(
                          controller: _ageController,
                          title: "Age",
                        ),),


                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor:appText,
                            disabledColor: appText,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child:   RadioListTile(
                                activeColor: appButton,
                                title: Text("Male", style: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.normal,
                                    color: primaryTextColor)),
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
                                    color: primaryTextColor)),
                                value: "Female",
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

                      !isloading
                          ? GestureDetector(
                        onTap: () {
                          UpdateUser();
                        },
                        child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.all(size.width * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                             color: appButton
                             /* gradient: LinearGradient(
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
                                  "Update",
                                  style: TextStyle(
                                      fontFamily: 'railway',
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.020,
                                      color: appBackground),
                                ))),
                      ) : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primaryColor,
                          )),
                    ],
                  ),
                ),
            ));
  }

 /* void checkValidation() {
    bool contactValid =
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(_numberController.text);

    if (_userNameController.text.isEmpty) {
      Message(context, "Enter Name");
    } else if (_emailController.text.isEmpty) {
      Message(context, "Enter Email");
    } else if (!contactValid) {
      Message(context, "Enter valid Contact Number");
    } else if (_numberController.text.isEmpty) {
      Message(context, "Enter Contact Number");
    }  else if (_bioController.text.isEmpty) {
      Message(context, "Enter Bio");
    } else if (_experienceController.text.isEmpty) {
      Message(context, "Enter Experience");
    } else {
      UpdateUser();
    }
  }*/


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
    print("UpdateProfile::$responseBody");

    var getdata = json.decode(response.body);

    if (statusCode == 200) {
      setState(() {
        isLoading = false;
        profile_image =  getdata["data"][0]["profile_image"];
        _userNameController.text =  getdata["data"][0]["name"]!=null?  getdata["data"][0]["name"]:'';
        _emailController.text = getdata["data"][0]["email"]!=null?getdata["data"][0]["email"]:'';
        _numberController.text =  getdata["data"][0]["contact_no"]!=null?getdata["data"][0]["contact_no"]:'';
        _bioController.text =  getdata["data"][0]["bio"]!=null?getdata["data"][0]["bio"]:'';
        _experienceController.text =  getdata["data"][0]["experience"]!=null?getdata["data"][0]["experience"]:'';
        _locationController.text = getdata["data"][0]["location"]!=null?getdata["data"][0]["location"]:'';
        _ageController.text =   getdata["data"][0]["age"].toString()!=null?getdata["data"][0]["age"].toString():'';
       if(getdata["data"][0]["gender"] == "female")
         {
           gender = "Female";
         }
       else{
         gender = "Male";
       }
        gender =  getdata["data"][0]["gender"];
      });
    }
  }




  Future<void> UpdateUser() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('yourang.shop', '/veeboss/public/api/v1/user/update');
    //----------------------------------------------------------
    var request = new http.MultipartRequest("POST", url);
    request.headers['x-session-token'] =prefs.getString('sessionToken')!;
    request.fields['name'] = _userNameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['location'] = _locationController.text;
    request.fields['age'] = _ageController.text;
    request.fields['gender'] = gender!;

    print(_locationController.text);

    if (_image != null) {
      request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            _image!.path,
          ));
    }

    if (_file != null){
      request.files.add(
          http.MultipartFile(
              'resume_file',
              File(_file!.path).readAsBytes().asStream(),
              File(_file!.path).lengthSync(),
              filename: _file!.path.split("/").last
          ));}



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

          Message(context, "Update Profile Successfully");
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
                isLoading = false;
              // todo
               if(prefs.getString("role") == "user")
                 {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return BottomNavigationBarEmploye();
                       },
                     ),
                   );
                 }
               else if (prefs.getString("role") == 'agent') {
                 Future.delayed(const Duration(milliseconds: 1000), () {
                   Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return bottomNavigationBarT2();
                       },
                     ),
                   );
                 });
               } else if (prefs.getString("role") == 'company') {
                 Future.delayed(const Duration(milliseconds: 1000), () {
                   Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return bottomNavigationBarEmployer();
                       },
                     ),
                   );
                 });
               }
               else if (prefs.getString("role") == 'vendor') {
                 Future.delayed(const Duration(milliseconds: 1000), () {
                   Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return BottomNavigationBarVendor();
                       },
                     ),
                   );
                 });
               }
            });
          });
        });
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, "Something went Wrong");
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
        _image = pickedImageFile;
      });
    } catch (error) {
      print("error: $error");
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Message(
      BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 800),
      ),
    );
  }
}


