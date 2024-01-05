
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:face_camera/face_camera.dart';
import 'package:sep/crop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FaceCamera.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? _capturedImage;
  Face? _detectedFace;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FaceCamera example app'),
          ),
          body: Builder(builder: (context) {
            if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => setState(() => _capturedImage = null),
                            child: const Text(
                              'Capture Again',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            )),
                        ElevatedButton(
                            onPressed: () {
                           print(l);
                           print(al);
                           print(r);
                           print(ar);
                           print(u);
                           print(au);
                           print(d);
                           print(ad);
                           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => cimg(imagePath: _capturedImage!.path),));
                              // _cropImage(_capturedImage!.path,cropFromLeft:al,cropFromRight:al,cropFromTop:au,cropFromBottom:auAd);
                            },
                            child: const Text(
                              'done',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            }
            // bool autoCap=false;
            return Stack(
              children: [
                SmartFaceCamera(
                  autoCapture: false,
                  defaultCameraLens: CameraLens.front,
                  onCapture: (File? image) {
                    setState(() => _capturedImage = image);
                  },
                  onFaceDetected: (Face? face) {
                    l=90;
                    setState(() => _detectedFace = face);
                    // if(al!>l!&&ar!<r!&&au!>u!&&ad!<d!){
                    //   setState(() {
                    //     autoCap=true;
                    //   });
                    // }
                  },
                  messageBuilder: (context, face) {
                    if (face == null) {
                      return _message('Place your face in the camera');
                    }
                    if (!face.wellPositioned) {
                      return _message('Center your face in the square');
                    }
                    return const SizedBox.shrink();
                  },
                ),
                if (_detectedFace != null)
                  _drawFaceOverlay(_detectedFace!),
              ],
            );
          },
          ),
      ),
    );
  }
  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );

Widget _drawFaceOverlay(Face face) {
  al= MediaQuery.of(context).size.width*20/100;
  au= MediaQuery.of(context).size.height*30/100;
  ar= MediaQuery.of(context).size.width*60/100+MediaQuery.of(context).size.width*20/100;
  ad= MediaQuery.of(context).size.height*40/100+MediaQuery.of(context).size.height*30/100;
  l=face.boundingBox.left;
  r=face.boundingBox.left+face.boundingBox.width;
  u=face.boundingBox.top;
  d=face.boundingBox.top+face.boundingBox.height;
  return Positioned(
    left: MediaQuery.of(context).size.width*20/100,
    top: MediaQuery.of(context).size.height*30/100,
    width: MediaQuery.of(context).size.width*60/100,
    height: MediaQuery.of(context).size.height*40/100,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green, // You can customize the color
          width: 2.0, // You can customize the border width
        ),
      ),
    ),
  );
}

double? l=0,al=0;
double? r=0,ar=0;
double? u=0,au=0;
double? d=0,ad=0;

}