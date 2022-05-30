import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:covidly/Screens/FaceMaskDetector.dart';
import 'package:covidly/Screens/SelfAssessmentPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

class MoreOptions extends StatefulWidget {
  const MoreOptions({Key key}) : super(key: key);

  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> with AutomaticKeepAliveClientMixin {
  Future<void> checkCameraAvailable() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    checkCameraAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "More Options",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07, fontWeight: FontWeight.w500),
                    )),
              ),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FaceMaskDetector(
                                      cameras: cameras,
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.greenAccent[100], width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.greenAccent[100].withOpacity(0.4),
                                  boxShadow: [BoxShadow(color: Colors.greenAccent[100].withOpacity(0.4), offset: Offset(0, 0), blurRadius: 14, spreadRadius: 8)]),
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/icons/ic_mask.png",
                                    width: 65,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Face Mask\nDetector", textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SelfAssessmentPage()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red[100], width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red[100].withOpacity(0.5),
                                  boxShadow: [BoxShadow(color: Colors.red[100].withOpacity(0.5), offset: Offset(0, 6), blurRadius: 14, spreadRadius: 8)]),
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    "assets/icons/ic_assessment.png",
                                    width: 75,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Self Assessment\nTest", textAlign: TextAlign.center),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: InkWell(
                  //           onTap: () {
                  //             Navigator.push(context, MaterialPageRoute(builder: (context) => SelfAssessmentResultPage(percentage: 0.61,)));
                  //           },
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(color: Colors.blue[100], width: 0.5),
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 color: Colors.blue[100].withOpacity(0.5),
                  //                 boxShadow: [BoxShadow(color: Colors.blue[100].withOpacity(0.5), offset: Offset(0, 6), blurRadius: 14, spreadRadius: 5)]),
                  //             height: 150,
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: <Widget>[
                  //                 Image.asset(
                  //                   "assets/icons/ic_mask.png",
                  //                   width: 65,
                  //                 ),
                  //                 SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Text("Face Mask\nDetector", textAlign: TextAlign.center)
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.orangeAccent[100], width: 0.5),
                  //               borderRadius: BorderRadius.circular(20),
                  //               color: Colors.orangeAccent[100].withOpacity(0.35),
                  //               boxShadow: [BoxShadow(color: Colors.orangeAccent[100].withOpacity(0.35), offset: Offset(0, 6), blurRadius: 14, spreadRadius: 5)]),
                  //           height: 150,
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget>[
                  //               Image.asset(
                  //                 "assets/icons/ic_mask.png",
                  //                 width: 65,
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text("Face Mask\nDetector", textAlign: TextAlign.center)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
