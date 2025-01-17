import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Styles/app_text_style.dart';
import '../Styles/my_colors.dart';
import '../utils/preference_utils.dart';
import '../utils/share_predata.dart';
import 'package:image_picker/image_picker.dart';


File imageFile = File("");

final String _text =
    'Toda persona tiene derecho a la educación. La educación debe ser gratuita, al menos en lo concerniente a la instrucción elemental y fundamental. La instrucción elemental será obligatoria. La instrucción técnica y profesional habrá de ser generalizada; el acceso a los estudios superiores será igual para todos, en función de los méritos respectivos.';
// TranslationModel _translated = TranslationModel(translatedText: '', detectedSourceLanguage: '');
// TranslationModel _detected = TranslationModel(translatedText: '', detectedSourceLanguage: '');

goToWelcomeScreen() async {
  var preferences = MySharedPref();
  await preferences.clearData(SharePreData.keySaveLoginModel);
  // Get.offAll(() => const WelcomeScreenView());
}

snackBar(BuildContext? context, String message) {
  if (!Get.isOverlaysOpen) {
    GetSnackBar(
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 3 ?? 2),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        style: AppTextStyle.smallSemiBold.copyWith(color: Colors.white),
      ),
    ).show();
  }

  // return ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     behavior: SnackBarBehavior.floating,
  //     content: Text(message),
  //     duration: const Duration(seconds: 2),
  //   ),
  // );
}

Future<String> openCamera(BuildContext context) async {
  String imagePathOfFile = "";
  await _getFile(ImageSource.camera).then((value) {
    if (imageFile.toString() != "File: ''") {
      // poster = imagePath;
      int sizeInBytes = imageFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      printData("File SizeFile Size ", sizeInMb.toString());

      if (sizeInMb > 5) {
        // This file is Longer
        snackBar(context, "Selected profile size is more than 5 MB");
        return;
      } else {
        imagePathOfFile = imageFile.path.toString();
      }
    }
  });

  return imagePathOfFile;
}

getDateOnlyInIndianFormat(DateTime originalDate) {
  String result = "";
  result = DateFormat("dd-MM-yyyy").format(originalDate);
  return result;
}

snackBarRed(BuildContext context, String message) {
  if (!Get.isOverlaysOpen) {
    GetSnackBar(
      backgroundColor: Colors.red.shade400,
      duration: Duration(seconds: 3 ?? 2),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        style: AppTextStyle.smallSemiBold.copyWith(color: Colors.white),
      ),
    ).show();
  }

  // return ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     backgroundColor: Colors.red.shade400,
  //     behavior: SnackBarBehavior.floating,
  //     content: Text(message),
  //     duration: const Duration(seconds: 2),
  //   ),
  // );
}

topSnackBar(BuildContext context, String title, String description) {
  return Get.snackbar(
      margin: const EdgeInsets.all(5),
      title,
      description,
      backgroundColor: Colors.white,
      colorText: Colors.black);
}

snackBarRapid(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}

void printData(String str, String val) {
  print("$str :::::::::::::  $val");
}

createdDateConverted(String originalDate) {
  String result = "";
  var date = DateTime.parse(originalDate);
  result = DateFormat("d MMM, yyyy | hh:mm a").format(date);
  return result;
}

getTimeInAmPM(DateTime dateTime) {
  String result = "";
  result = DateFormat("hh:mm a").format(dateTime);
  return result;
}

getDateOnly(DateTime originalDate) {
  String result = "";
  var date = (originalDate);
  result = DateFormat("d MMM, yyyy").format(date);
  return result;
}

getDateFormtYYYYMMDDOnly(String originalDate) {
  String result = "";
  var date = DateTime.parse(originalDate);
  result = DateFormat("yyyy-MM-dd").format(date);
  return result;
}

getDateFormatDDMMYYYYOnly(DateTime originalDate) {
  String result = "";
  result = DateFormat("dd-MM-yyyy").format(originalDate);
  return result;
}

createdDateTimeConverted(String originalDate) {
  String result = "";
  var date = DateTime.parse(originalDate);
  result = DateFormat("d MMM, yyyy\nhh:mm a").format(date);
  return result;
}

// Select Poto
Future<String> selectPhoto(BuildContext context) async {
  String imagePathOfFile = "";

  await showImagePicker(context).then((value) {
    if (imageFile.toString() != "File: ''") {
      // poster = imagePath;
      int sizeInBytes = imageFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      printData("File SizeFile Size ", sizeInMb.toString());

      if (sizeInMb > 5) {
        // This file is Longer
        snackBar(context, "Selected profile size is more than 5 MB");
        return;
      } else {
        imagePathOfFile = imageFile.path.toString();
      }
    }

    // printData(runtimeType.toString(),imagePath.toString());
  });

  return imagePathOfFile;
}

Future showImagePicker(context) {
  // imagePath = null;
  Future<void> future = showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    _getFile(ImageSource.gallery)
                        .then((value) => Navigator.of(context).pop());
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getFile(ImageSource.camera)
                      .then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          ),
        ),
      );
    },
  );
  return future;
}

Future _getFile(ImageSource source) async {
  XFile? pickedFile = await ImagePicker().pickImage(
    source: source,
    imageQuality: 50,
  );
  print("Image Path " + pickedFile!.path);

  if (pickedFile != null) {
    return imageFile = File(pickedFile.path);
  } else {
    return "";
  }
}

void onLoading(BuildContext context, String msg) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator()
            // Image.asset(icon_waiting, height: 80.w, width: 80.h)
            // SizedBox(
            //   height: 200.w,
            //   width: 200.h,
            //   child: CircularProgressIndicator()
            //
            //   // Lottie.asset(
            //   //   icon_loader_json,
            //   //   repeat: true,
            //   //   reverse: true,
            //   //   animate: true,
            //   // ),
            // ),
            // Container(
            //     width: 50,
            //     height: 50,
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.green,
            //       ) , child: Image.asset(icon_waiting, height: 35, width: 35)),
            );
        // child: const CircularProgressIndicator(
        //   backgroundColor: Colors.white,
        //   valueColor: AlwaysStoppedAnimation<Color>(
        //     bg_btn_199a8e, //<-- SEE HERE
        //   ),
        // )),
        // );
      },
    );
  });
}
