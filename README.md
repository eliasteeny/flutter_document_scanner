# document_scanner

A plugin for Flutter apps that adds document scanning functionality on Android.

## Warning
 Document Scanner customization options aren't working for now

#

## Setup

Handle camera access permission

### **IOS**

Add a boolean property to the app's Info.plist file with the key io.flutter.embedded_views_preview and the value true to enable embedded views preview.

    <key>io.flutter.embedded_views_preview</key>
    <true/>

Add a String property to the app's Info.plist file with the key NSCameraUsageDescription and the value as the description for why your app needs camera access.

	<key>NSCameraUsageDescription</key>
	<string>Camera Permission Description</string>

### **Android**

minSdkVersion should be at least 19



## How to use ?

first add as a dependency in pubspec.yaml

import:

```
import 'package:document_scanner/document_scanner.dart';
```

then use it as a widget:
```
DocumentScanner(
    onPictureTaken: (String image) {
        print("document : " + image);
    },
                          
)
```

#

## Contributing

### Step 1

- Fork this project's repo : https://github.com/eliasteeny/flutter_document_scanner

### Step 2

-  Create a new pull request.

#

## License
This project is licensed under the MIT License - see the LICENSE.md file for details

