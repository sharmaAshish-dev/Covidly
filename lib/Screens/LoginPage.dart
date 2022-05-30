import 'package:covidly/Screens/MainScreen.dart';
import 'package:covidly/Widgets/Buttons/OutLineButton.dart';
import 'package:covidly/Widgets/Buttons/buttonWithLoading.dart';
import 'package:covidly/Widgets/TextInputWidgets/InputWithIcon.dart';
import 'package:covidly/Widgets/colors/LightTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  bool isReset = false;
  bool verifiyingOtp = false;
  String verificationID;
  bool codeSent = false;

  int _pageState = 0;

  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 100;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
          print("Keyboard State Changed : $visible");
        });
      },
    );
  }

  Future<void> registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authResult) {
      _auth.signInWithCredential(authResult);
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('yes ${authException.message}');
      setState(() {
        verifiyingOtp = false;
      });
      Fluttertoast.showToast(msg: "Invalid OTP", gravity: ToastGravity.BOTTOM);
    };

    final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
      this.verificationID = verID;
      setState(() {
        codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout authTimeout = (String verID) {
      this.verificationID = verID;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + mobile,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: authTimeout);
  }

  Future<void> verifyOtp(smsCode, verID) async {
    setState(() {
      verifiyingOtp = true;
    });

    AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verID, smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) => setState(() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        }));
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 270;
    _registerHeight = windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0xFFB40284A);

        _headingTop = 100;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 1:
        _backgroundColor = LightTheme.primaryDarkColor;
        _headingColor = Colors.white;

        _headingTop = 90;

        _loginWidth = windowWidth;
        _loginOpacity = 1;

        _loginYOffset = _keyboardVisible ? 40 : 270;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = LightTheme.primaryColor;
        _headingColor = Colors.white;

        _headingTop = 80;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.6;

        _loginYOffset = _keyboardVisible ? 30 : 240;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;

        _loginXOffset = 20;
        _registerYOffset = _keyboardVisible ? 55 : 270;
        _registerHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
        break;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onVerticalDragDown: (_) {
                      setState(() {
                        _pageState = 0;
                      });
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 1000),
                            margin: EdgeInsets.only(
                              top: _headingTop,
                            ),
                            child: Text(
                              "Covidly App",
                              style: TextStyle(color: _headingColor, fontSize: 28),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              "An App for Covid-19 updates, best practices and relevant advisories of COVID-19",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: _headingColor, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Lottie.asset(
                        'assets/lottie/covid_fighting.json',
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_pageState != 0) {
                            _pageState = 0;
                          } else {
                            _pageState = 1;
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(32, 32, 32, 20),
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(color: LightTheme.primaryDarkColor, borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Container(child: Text("Made with ")),
                              Icon(
                                CupertinoIcons.heart_solid,
                                color: Colors.red,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          AnimatedContainer(
            padding: EdgeInsets.all(32),
            width: _loginWidth,
            height: _loginHeight,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
            decoration: BoxDecoration(color: Colors.white.withOpacity(_loginOpacity), borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.phone_android,
                      hint: "Enter Phone Number...",
                      inputType: TextInputType.number,
                      maxLength: 10,
                      inputController: phoneController,
                      isTextHidden: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          if (phoneController.text.length != 10) {
                            Fluttertoast.showToast(msg: "Please enter a valid number");
                          } else {
                            setState(() {
                              isReset = true;
                              registerUser(phoneController.text, context);
                              if (true) {
                                _pageState = 2;
                              }
                            });
                          }
                        },
                        child: ButtonWithLoading(
                          isReset: isReset,
                          buttonTitle: "Send otp",
                          btnColor: LightTheme.primaryDarkColor,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: _registerHeight,
            padding: EdgeInsets.all(32),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _registerYOffset, 1),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "OTP Verification",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.phone_android,
                      hint: "Enter OTP",
                      inputType: TextInputType.number,
                      inputController: otpController,
                      isTextHidden: false,
                    ),
                    //   SizedBox(height: 20,),
                    //   InputWithIcon(
                    //     icon: Icons.vpn_key,
                    //     hint: "Enter Password...",
                    //   )
                    //
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (otpController.text.length < 6) {
                          Fluttertoast.showToast(msg: "Invalid OTP");
                        } else {
                          verifyOtp(otpController.text, verificationID);
                        }
                      },
                      child: ButtonWithLoading(
                        isReset: verifiyingOtp,
                        buttonTitle: "Verify otp",
                        btnColor: LightTheme.primaryDarkColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Back To Login",
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  fetchStudentData(BuildContext context, String uMobile, String uPass) async {
    if (uMobile.isEmpty || uPass.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the details", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.white, textColor: Colors.black87);

      setState(() {
        isReset = false;
      });
    } else {
      if (uMobile.length < 10) {
        Fluttertoast.showToast(msg: "Please enter a valid phone number", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.white, textColor: Colors.black87);

        setState(() {
          isReset = false;
        });
      } else {
        setState(() {
          isReset = true;
        });
      }
    }
  }
}
