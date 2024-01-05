// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'main.dart';

class cimg extends StatefulWidget {
  final String imagePath;

  const cimg({Key? key,
  required this.imagePath,
}) : super(key: key);

  @override
  State<cimg> createState() => _cimgState();
}

class _cimgState extends State<cimg> {
  @override
  File? _croppedImage;
  Future<void> _cropImage(String imagePath) async {
  ImageCropper imageCropper = ImageCropper();
  File? croppedFile = await imageCropper.cropImage(
    sourcePath: imagePath,
    cropStyle: CropStyle.rectangle,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio16x9,
    ],
    uiSettings: [AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: Colors.deepOrange,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    ),],
    maxWidth: 800,
    maxHeight: 800,
  )as File?;

  if (croppedFile != null) {
    _croppedImage=croppedFile;
    // Do something with the cropped image file
    print('Cropped image path: ${croppedFile.path}');
  } else {
    // Crop operation was canceled by the user
    print('Crop operation canceled');
  }
}

  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(builder: (context) {
      if (_croppedImage != null) {
        return Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.file(
                _croppedImage!,
                width: double.maxFinite,
                fit: BoxFit.fitWidth,
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () { setState(() => _croppedImage = null);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyApp(),));},
                      child: const Text(
                        'Capture Again',
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
      else {
         _cropImage(widget.imagePath);
        return CircularProgressIndicator();
          // ElevatedButton(
          //     onPressed: () =>
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => MyApp(),)),
          //     child: const Text(
          //       'Camera',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //           fontSize: 14, fontWeight: FontWeight.w700),
          //     ));
      }

}),);
}}