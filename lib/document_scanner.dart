import 'dart:async';
import 'dart:io' show Platform;

import 'package:document_scanner/scannedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:document_scanner/scannedImage.dart';

const String _methodChannelIdentifier = 'document_scanner';

/// onDocumentScanned gets called when the scanner successfully scans a rectangle (document)

class DocumentScanner extends StatefulWidget {
  final Function(ScannedImage) onDocumentScanned;

  // final bool documentAnimation;
  // final String overlayColor;
  // final int detectionCountBeforeCapture;
  // final int detectionRefreshRateInMS;
  // final bool enableTorch;
  // final bool useFrontCam;
  // final double brightness;
  // final double saturation;
  // final double contrast;
  // final double quality;
  // final bool useBase64;
  // final bool saveInAppDocument;
  // final bool captureMultiple;
  // final bool manualOnly;
  // final bool noGrayScale;

  DocumentScanner({
    @required this.onDocumentScanned,
    // this.documentAnimation,
    // this.overlayColor,
    // this.detectionCountBeforeCapture,
    // this.detectionRefreshRateInMS,
    // this.enableTorch,
    // this.useFrontCam,
    // this.brightness,
    // this.saturation,
    // this.contrast,
    // this.quality,
    // this.useBase64,
    // this.saveInAppDocument,
    // this.captureMultiple,
    // this.manualOnly,
    // this.noGrayScale,
  });

  final MethodChannel _channel = const MethodChannel(_methodChannelIdentifier);

  @override
  _DocState createState() => _DocState();
}

class _DocState extends State<DocumentScanner> {
  @override
  void initState() {
    print("initializing document scanner state");
    widget._channel.setMethodCallHandler(_onDocumentScanned);
    super.initState();
  }

  Future<dynamic> _onDocumentScanned(MethodCall call) async {
    if (call.method == "onPictureTaken") {
      Map<String, dynamic> argsAsMap =
          Map<String, dynamic>.from(call.arguments);

      ScannedImage scannedImage = ScannedImage.fromMap(argsAsMap);

      // ScannedImage scannedImage = ScannedImage(
      //     croppedImage: argsAsMap["croppedImage"],
      //     initialImage: argsAsMap["initialImage"]);

      // print("scanned image decoded");
      // print(scannedImage.toJson());

      if (scannedImage.croppedImage != null) {
        // print("scanned image not null");
        widget.onDocumentScanned(scannedImage);
      }
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: _methodChannelIdentifier,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: _getParams(),
      );
    } else if (Platform.isIOS) {
      print("platform ios");
      return UiKitView(
        viewType: _methodChannelIdentifier,
        creationParams: _getParams(),
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      throw ("Current Platform is not supported");
    }
  }

  Map<String, dynamic> _getParams() {
    // Map<String, dynamic> allParams = {
    //   "documentAnimation": widget.documentAnimation,
    //   "overlayColor": widget.overlayColor,
    //   "detectionCountBeforeCapture": widget.detectionCountBeforeCapture,
    //   "enableTorch": widget.enableTorch,
    //   "manualOnly": widget.manualOnly,
    //   "noGrayScale": widget.noGrayScale,
    //   "brightness": widget.brightness,
    //   "contrast": widget.contrast,
    //   "saturation": widget.saturation,
    // };

    // Map<String, dynamic> nonNullParams = {};
    // allParams.forEach((key, value) {
    //   if (value != null) {
    //     nonNullParams.addAll({key: value});
    //   }
    // });

    // return nonNullParams;
    return {};
  }
}
