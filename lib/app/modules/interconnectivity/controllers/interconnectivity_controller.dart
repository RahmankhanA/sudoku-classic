import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/interconnectivity/views/interconnectivity_view.dart';

class InterconnectivityController extends GetxController {
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  int number = 0;

  @override
  void onInit() {
    initialise();
    // connectivityListen();
    super.onInit();
  }

  @override
  void onClose() {
    _controller.close();

    super.onClose();
  }

  void connectivityListen() {
    myStream.listen((source) {
      String string = '';
      log('source $source');
      // 1.
      log(source.toString());
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      //  Get.snackbar('Connection Status', string,
      //       backgroundColor: LevelColor.levelMapBackgroundColor,
      //       snackPosition: SnackPosition.BOTTOM);
    });
  }

  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      // print(result);
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    log("isOnline $isOnline");
    if (!isOnline) {
      showConfirmationDialogForEnableInternet();
    }
    // Get.closeAllSnackbars();
    // Get.snackbar('Connection Status', isOnline ? "Online" : "Offline",
    //     backgroundColor: LevelColor.levelMapBackgroundColor,
    //     snackPosition: SnackPosition.BOTTOM);
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();

  showConfirmationDialogForEnableInternet() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmationDialogForInternet(
          message: 'Enable Internet \nTo run the app smoothly',
          onConfirm: () async {
            Get.back();
            if (number % 3 != 0) {
              ConnectivityResult result =
                  await _networkConnectivity.checkConnectivity();
              _checkStatus(result);
            }
            number++;
          },
        );
      },
    );
  }
}
