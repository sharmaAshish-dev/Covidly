import 'package:camera/camera.dart';
import 'package:covidly/Widgets/Buttons/backButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class FaceMaskDetector extends StatefulWidget {
  final List<CameraDescription> cameras;

  const FaceMaskDetector({Key key, @required this.cameras}) : super(key: key);

  @override
  _FaceMaskDetectorState createState() => _FaceMaskDetectorState();
}

class _FaceMaskDetectorState extends State<FaceMaskDetector> with AutomaticKeepAliveClientMixin {
  CameraImage cameraImage;
  CameraController cameraController;
  String result = "";

  initCamera() {
    cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {
        cameraController.startImageStream((imageStream) {
          cameraImage = imageStream;
          runModel();
        });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  runModel() async {
    if (cameraImage != null) {
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.2,
          asynch: true);
      recognitions.forEach((element) {
        setState(() {
          result = element["label"];
          print(result);
        });
      });
    }
  }

  Future<void> disposeTFModel() async {
    await Tflite?.close();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    disposeTFModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: !cameraController.value.isInitialized
            ? Container()
            : Stack(
                fit: StackFit.expand,
                children: [
                  AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                    // child: Container(
                    //   color: Colors.blue,
                    // ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "SCANNING",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        CustomPaint(
                          painter: BorderPainter(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            // result,
                            // result.split(" ")[1] + " " + result.split(" ")[2],
                            result.contains("Incorrect") ? "With mask" : "Without mask",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: GestureDetector(
                          onTap: () async {
                            await disposeTFModel();
                            Navigator.of(context).pop();
                          },
                          child: backButton(
                            borderColor: Colors.white,
                            containerColor: Colors.white,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            result.contains("Incorrect") ? "assets/images/boy_with_mask.png" : "assets/images/boy_without_mask.png",
                            // "assets/images/boy_without_mask.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = 3.0;
    final radius = 20.0;
    final tRadius = 2 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
