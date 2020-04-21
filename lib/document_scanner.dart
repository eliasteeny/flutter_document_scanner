import 'dart:async';

import 'package:document_scanner/scannedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:document_scanner/scannedImage.dart';

class DocumentScanner extends StatefulWidget {
  final Function(String) onPictureTaken;
  final MethodChannel channel = const MethodChannel('document_scanner');

  final bool documentAnimation;
  final String overlayColor;
  final int detectionCountBeforeCapture;
  final int detectionRefreshRateInMS;
  final bool enableTorch;
  final bool useFrontCam;
  final double brightness;
  final double saturation;
  final double contrast;
  final double quality;
  final bool useBase64;
  final bool saveInAppDocument;
  final bool captureMultiple;
  final bool manualOnly;
  final bool noGrayScale;

  DocumentScanner({
    @required this.onPictureTaken,
    this.documentAnimation,
    this.overlayColor,
    this.detectionCountBeforeCapture,
    this.detectionRefreshRateInMS,
    this.enableTorch,
    this.useFrontCam,
    this.brightness,
    this.saturation,
    this.contrast,
    this.quality,
    this.useBase64,
    this.saveInAppDocument,
    this.captureMultiple,
    this.manualOnly,
    this.noGrayScale,
  });

  @override
  _DocState createState() => _DocState();
}

class _DocState extends State<DocumentScanner> {
  @override
  void initState() {
    widget.channel.setMethodCallHandler((MethodCall call) {
      if (call.method == "onPictureTaken") {
        Map<String, dynamic> argsAsMap =
            Map<String, dynamic>.from(call.arguments);

        widget.onPictureTaken(argsAsMap["croppedImage"]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      viewType: "document_scanner",
      creationParamsCodec: const StandardMessageCodec(),
      creationParams: getParams(),
    );
  }

  Map<String, dynamic> getParams() {
    Map<String, dynamic> allParams = {
      "documentAnimation": widget.documentAnimation,
      "overlayColor": widget.overlayColor,
      "detectionCountBeforeCapture": widget.detectionCountBeforeCapture,
      "enableTorch": widget.enableTorch,
      "manualOnly": widget.manualOnly,
      "noGrayScale": widget.noGrayScale,
      "brightness": widget.brightness,
      "contrast": widget.contrast,
    };
    Map<String, dynamic> nonNullParams = {};
    allParams.forEach((key, value) {
      if (value != null) {
        nonNullParams.addAll({key: value});
      }
    });

    return nonNullParams;
  }
}
