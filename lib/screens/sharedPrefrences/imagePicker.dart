import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:tatkal_jobs_app/screens/Post_Job_Screen.dart';

// final String f = "";

class ImagePkr extends StatefulWidget {
  static const routeName = '/image';
  Function getimageLink;

  // var getimageLink;
  // String t = f;

  ImagePkr({Key? key, required this.getimageLink}) : super(key: key);
  @override
  _ImagePkrState createState() => _ImagePkrState(this.getimageLink);
}

class _ImagePkrState extends State<ImagePkr> {
  List<XFile>? _imageFileList;

  late final Function getImageLink;
  _ImagePkrState(this.getImageLink);
  // String s;
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  bool isUploaded = false;
  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (context, index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child:
                    //  kIsWeb
                    //     ? Image.network(_imageFileList![index].path)
                    //     :
                    Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
      } else {
        // isVideo = false;
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future uploadImageToFirebase(
      BuildContext context, XFile _file, String folder) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      File file = File(_file.path);
      Reference ref =
          storage.ref().child("images/" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(file);
      // uploadTask.onError((error, stackTrace) {
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.WARNING,
      //     animType: AnimType.RIGHSLIDE,
      //     title: 'You can not disable',
      //     btnOkColor: Colors.blue,
      //     btnOkOnPress: () {
      //       // Navigator.pop(context);
      //       return;
      //     },
      //   ).show();
      // }).whenComplete(() => null);
      print("Starting upload");
      final res = await uploadTask.then((res) {
        res.ref.getDownloadURL().then((value) {
          print(value);
          widget.getimageLink(value);
          setState(() {
            isUploaded = false;
          });
          Navigator.of(context).pop();
          final snackBar = SnackBar(
            content: const Text('Image Uploaded'),
            backgroundColor: (Colors.black),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }).onError((error, stackTrace) {
        setState(() {
          isUploaded = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.RIGHSLIDE,
          title: 'Sorry, but we could not upload media at the moment.',
          btnOkColor: Colors.blue,
          btnOkOnPress: () {
            setState(() {
              isUploaded = false;
            });
            // Navigator.pop(context);
            return;
          },
        ).show();
        return null;
      });
    } catch (e) {
      setState(() {
        isUploaded = false;
      });
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: isUploaded
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return const Text(
                                      'You have not yet picked an image.',
                                      textAlign: TextAlign.center,
                                    );
                                  case ConnectionState.done:
                                    return _handlePreview();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        'Pick image/video error: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return const Text(
                                        'You have not yet picked an image.',
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                }
                              },
                            )
                          : _handlePreview(),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Semantics(
                          label: 'image_picker_example_from_gallery',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  _onImageButtonPressed(ImageSource.gallery,
                                      context: context);
                                  ;
                                },
                                heroTag: 'image0',
                                tooltip: 'Pick Image from gallery',
                                child: const Icon(Icons.photo),
                              ),
                              Text(
                                'Gallery',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  // isVideo = false;
                                  _onImageButtonPressed(ImageSource.camera,
                                      context: context);
                                },
                                heroTag: 'image2',
                                tooltip: 'Take a Photo',
                                child: const Icon(Icons.camera_alt),
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(fontSize: 20),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Container(
              height: 50,
              width: 50,
              child: LottieBuilder.asset("assets/lottie/upload1.json")),
          TextButton(
              onPressed: () {
                print(
                    "+++++++++|||||||||||||||||||||||||||||||||||+++++++++++++++++");
                // print("$  ");
                print(_imageFileList);
                if (_imageFileList == null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO_REVERSED,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Pick Image',
                    // desc: 'Dialog description here.............',
                    // btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  )..show();
                } else {
                  setState(() {
                    isUploaded = true;
                  });
                  uploadImageToFirebase(context, _imageFileList![0], "images");
                }

                print(
                    "+++++++++|||||||||||||||||||||||||||||||||||+++++++++++++++++");
              },
              child: Text('Upload Image')),
          Spacer(),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('From Gallery'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    // double? width = maxWidthController.text.isNotEmpty
                    //     ? double.parse(maxWidthController.text)
                    //     : null;
                    // double? height = maxHeightController.text.isNotEmpty
                    //     ? double.parse(maxHeightController.text)
                    //     : null;
                    // int? quality = qualityController.text.isNotEmpty
                    //     ? int.parse(qualityController.text)
                    //     : null;
                    double? width = null;
                    double? height = null;
                    int? quality = 80;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Text(
        'lorem',
        style: TextStyle(fontSize: 20),
      );
      // Center(
      //   child: AspectRatio(
      //     aspectRatio: controller!.value.aspectRatio,
      //     child: VideoPlayer(controller!),
      //   ),
      // );
    } else {
      return Container();
    }
  }
}

class M extends StatefulWidget {
  final Function gett;

  const M({Key? key, required this.gett}) : super(key: key);

  @override
  _MState createState() => _MState(gett: gett);
}

class _MState extends State<M> {
  final Function gett;
  _MState({
    required this.gett,
  });
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
