import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

Future<File> compressImageFile(File file) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    "${(await getApplicationDocumentsDirectory()).path}/sat-${DateTime.now().millisecondsSinceEpoch}.jpg",
    minWidth: 918,
    minHeight: 1224,
    quality: 80,
    inSampleSize: 2,
  );
  return result;
}

Future<String> base64FromFile(pickedFile) async {
  var file = await compressImageFile(pickedFile);
  if (file == null) return null;
  List<int> imageBytes = file.readAsBytesSync();
  var codec = Base64Codec();
  String encoded = codec.encode(imageBytes);
  return encoded;
}

Future<File> base64ToFile(String encodedData, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.png');
  await file.writeAsString(encodedData);

  return file;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

Future<File> getImageFileFromByteData(ByteData byteData, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.png');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<File> getFileFromString(String encoded, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.jpg');
  await file.writeAsString(encoded);
  return file;
}

Future<File> getImageFileFromUint8List(Uint8List list, String name) async {
  final file = File(
      '${(await getTemporaryDirectory()).path}/${name}_${DateTime.now().millisecondsSinceEpoch}.jpg');
  await file.writeAsBytes(list);
  return file;
}

Future<File> captureOrPickImage(context, [selection = 1]) async {
  File image;
  if (selection != null) {
    File pickedImage;
    //if (selection == 2) {
    pickedImage = await ImagePicker.pickImage(
      source: (selection == 1) ? ImageSource.camera : ImageSource.gallery,
    );
    /*} else {
      var photo = await CameraPicker.pickFromCamera(
        context,
        textDelegate: EnglishCameraPickerTextDelegate(),
        isAllowRecording: true,
      );
      if (photo != null) {
        pickedImage = await photo.originFile;
      }
    }*/

    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
    }
  }
  return image;
}
