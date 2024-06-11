import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommonFunctions {
  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }

  void displaYSnacKBaR(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

pickImage(ImageSource source) async {
  ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: ImageSource.gallery);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No Image is selected");
}

String userName = "";
