# flutter_document_scanner

A plugin for Flutter apps that adds document scanning functionality on Android.

## Getting Started

TBD

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

## License
This project is licensed under the MIT License - see the LICENSE.md file for details

