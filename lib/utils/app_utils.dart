import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
import 'app_helpers.dart';
import 'assets.dart';

class Utils {
  Utils._();

  static Future<bool> hasNetwork({bool? showToast}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.isEmpty ||
        connectivityResult.first == ConnectivityResult.none) {
      toast(msg: "Please check your Internet Connection", isError: true);
      return false;
    } else {
      return true;
    }
  }

  static Map<String, double> tableColumnWidths(double totalWidth) {
    return {
      "column5": totalWidth * 0.05,
      "column7": totalWidth * 0.07,
      "column8": totalWidth * 0.08,
      "column10": totalWidth * 0.10,
      "column15": totalWidth * 0.15,
      "column20": totalWidth * 0.20,
      "column25": totalWidth * 0.25,
      "column30": totalWidth * 0.30,
      "column35": totalWidth * 0.35,
      "column40": totalWidth * 0.40,
      "column45": totalWidth * 0.45,
      "column50": totalWidth * 0.50,
      "column60": totalWidth * 0.60,
    };
  }

  static String extractPatientName(String text) {
    RegExp nameRegex = RegExp(r'Patient\s*name\s*([A-Z][a-z]+(?:\s[A-Z][a-z]+)?)', caseSensitive: false);
    Match? match = nameRegex.firstMatch(text);
    return match != null ? match.group(1)!.trim() : "Not Found";
  }

  static String extractAge(String text) {
    RegExp ageRegex = RegExp(r'\b[Aa]ge[:\s]*(\d+)\b');
    Match? match = ageRegex.firstMatch(text);
    return match != null ? match.group(1)! : "0";
  }

  static String extractWeight(String text) {
    RegExp weightRegex = RegExp(r'\b[Ww]eight[:\s]*(\d+)\s*(kg|Kg|KG|kilograms|Kilograms)?\b');
    Match? match = weightRegex.firstMatch(text);
    return match != null ? match.group(1)! + " kg" : "0";
  }

  static String getImageFromPlace(String photoReference){
     return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$photoReference&key=AIzaSyCZoMXX90GjeZAL8uloGkPOx8NFPZqotHo";
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }



  static String getFullName(String? firstName, String? lastName) {
    if (firstName != null && lastName != null) {
      return "$firstName $lastName";
    } else if (firstName != null) {
      return firstName;
    } else {
      return "";
    }
  }

  static String extractVideoId(String inputString) {
    RegExp regExp = RegExp(r'/videos/(\d+)');

    Match? match = regExp.firstMatch(inputString);
    return match != null ? match.group(1) ?? '' : '';
  }

  static String getJoiningDate(DateTime dateTime){
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    print(formattedDate);
    return formattedDate;
  }


  // static Future<void> showLoader() async {
  //   BotToast.cleanAll();
  //   BotToast.showCustomLoading(
  //       useSafeArea: true,
  //       allowClick: false,
  //       clickClose: false,
  //       ignoreContentClick: true,
  //       align: Alignment.center,
  //       toastBuilder: (void Function() cancelFunc) {
  //         return Lottie.asset(Assets.appLoading, height: 150);
  //       });
  // }

  static void hideLoader() {
    BotToast.closeAllLoading();
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

 static void toast({required String msg, bool isError = true, Duration? duration}) {
    BotToast.showCustomText(
        duration: duration ?? const Duration(seconds: 2),
        toastBuilder: (cancelFunc) => Align(
          alignment: const Alignment(0, 0.8),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0.0, 2.0,),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isError
                            ? Colors.red.withOpacity(0.2)
                            : Colors.green.withOpacity(0.2),
                      ),
                      child: Icon(
                        isError ? Icons.error : Icons.done_all,
                        color: isError ? Colors.red : Colors.green,
                      ),
                    ),
                    xWidth(10),
                    Flexible(
                      child: Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: isError ? Colors.red : Colors.green,

                        ),
                      ),
                    ),
                    xWidth(10),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}