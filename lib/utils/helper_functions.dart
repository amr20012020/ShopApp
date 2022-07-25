import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/utils/size_config.dart';

/*showErrorDialog(String error) {
  Get.dialog(AlertDialog(
    title: Text(
      "error occurred".tr,
      style: TextStyle(
        color: Get.theme.primaryColorDark,
      ),
    ),
    backgroundColor: Get.theme.canvasColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/svg/error.svg",
          height: 30 * imageSizeMultiplier,
        ),
        SizedBox(
          height: 2 * heightMultiplier,
        ),
        Text(
          error,
          style: TextStyle(
            color: Get.theme.primaryColorDark,
            fontSize: 2.2 * textMultiplier,
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("okay".tr))
    ],
  ));
} */

/*showSuccessDialog(String msg, {Function? onAction}) {
  Get.dialog(
    AlertDialog(
      title: Text(
        "success".tr,
        style: TextStyle(
          color: Get.theme.primaryColorDark,
        ),
      ),
      backgroundColor: Get.theme.canvasColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/svg/success.svg",
            height: 30 * imageSizeMultiplier,
          ),
          SizedBox(
            height: 2 * heightMultiplier,
          ),
          Text(
            msg,
            style: TextStyle(
              color: Get.theme.primaryColorDark,
              fontSize: 2.2 * textMultiplier,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              if (onAction != null) {
                onAction();
              }
            },
            child: Text("okay".tr))
      ],
    ),
    barrierDismissible: onAction == null,
  );
} */

/*checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
} */

/*showSnackBar(String msg) {
  Get.rawSnackbar(
    messageText: Text(
      msg,
      style: TextStyle(color: Get.theme.primaryColorDark),
    ),
    backgroundColor: Get.theme.canvasColor,
  );
} */
