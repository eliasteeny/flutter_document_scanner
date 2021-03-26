import 'dart:convert';

import 'dart:io';

class ScannedImage {
  ScannedImage({
    // this.rectangleCoordinates,
    this.croppedImage,
    this.width,
    this.initialImage,
    this.height,
  });

  // RectangleCoordinates rectangleCoordinates;
  String croppedImage;
  int width;
  String initialImage;
  int height;

  factory ScannedImage.fromJson(String str) =>
      ScannedImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScannedImage.fromMap(Map<String, dynamic> json) => ScannedImage(
        // rectangleCoordinates: json["rectangleCoordinates"] == null
        //     ? null
        //     : RectangleCoordinates.fromMap(json["rectangleCoordinates"]),
        croppedImage:
            json["croppedImage"] == null ? null : json["croppedImage"],
        width: json["width"] == null ? null : json["width"],
        initialImage:
            json["initialImage"] == null ? null : json["initialImage"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toMap() => {
        // "rectangleCoordinates": rectangleCoordinates == null ? null : rectangleCoordinates.toMap(),
        "croppedImage": croppedImage == null ? null : croppedImage,
        "width": width == null ? null : width,
        "initialImage": initialImage == null ? null : initialImage,
        "height": height == null ? null : height,
      };

  File getScannedDocumentAsFile() => File.fromUri(
        Uri.parse(croppedImage),
      );
}

// class RectangleCoordinates {
//   RectangleCoordinates({
//     this.bottomLeft,
//     this.bottomRight,
//     this.topLeft,
//     this.topRight,
//   });

//   Corner bottomLeft;
//   Corner bottomRight;
//   Corner topLeft;
//   Corner topRight;

//   factory RectangleCoordinates.fromJson(String str) =>
//       RectangleCoordinates.fromMap(json.decode(str));

//   // String toJson() => json.encode(toMap());

//   factory RectangleCoordinates.fromMap(Map<String, dynamic> json) =>
//       RectangleCoordinates(
//         bottomLeft: json["bottomLeft"] == null
//             ? null
//             : Corner.fromMap(json["bottomLeft"]),
//         bottomRight: json["bottomRight"] == null
//             ? null
//             : Corner.fromMap(json["bottomRight"]),
//         topLeft:
//             json["topLeft"] == null ? null : Corner.fromMap(json["topLeft"]),
//         topRight:
//             json["topRight"] == null ? null : Corner.fromMap(json["topRight"]),
//       );

//   // Map<String, dynamic> toMap() => {
//   //     "bottomLeft": bottomLeft == null ? null : bottomLeft.toMap(),
//   //     "bottomRight": bottomRight == null ? null : bottomRight.toMap(),
//   //     "topLeft": topLeft == null ? null : topLeft.toMap(),
//   //     "topRight": topRight == null ? null : topRight.toMap(),
//   // };
// }

// class Corner {
//   Corner({
//     this.x,
//     this.y,
//   });

//   double x;
//   double y;

//   factory Corner.fromJson(String str) => Corner.fromMap(json.decode(str));

//   // String toJson() => json.encode(toMap());

//   factory Corner.fromMap(Map<String, dynamic> json) => Corner(
//         x: json["x"] == null ? null : json["x"],
//         y: json["y"] == null ? null : json["y"],
//       );

//   // Map<String, dynamic> toMap() => {
//   //     "x": x == null ? null : x,
//   //     "y": y == null ? null : y,
//   // };
// }
