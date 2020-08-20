#import "DocumentScannerFactory.h"
#import "DocumentScannerView.h"

#import <AVFoundation/AVFoundation.h>

@implementation DocumentScannerFactory {
  NSObject<FlutterPluginRegistrar>* _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    
    [self requestCameraPermissionsIfNeeded];
     return [[ScannerController alloc] initWithFrame:frame
                                           viewIdentifier:viewId
                                                arguments:args
                                                registrar:_registrar];
//    ScannerController *controller = [ScannerController alloc];
//    return controller;
    
//  return [[FLTGoogleMapController alloc] initWithFrame:frame
//                                        viewIdentifier:viewId
//                                             arguments:args
//                                             registrar:_registrar];
}
- (void)requestCameraPermissionsIfNeeded {
    
    // check camera authorization status
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized: { // camera authorized
            // do camera intensive stuff
        }
            break;
        case AVAuthorizationStatusNotDetermined: { // request authorization
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(granted) {
                        // do camera intensive stuff
                    } else {
                        [self notifyUserOfCameraAccessDenial];
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self notifyUserOfCameraAccessDenial];
            });
        }
            break;
        default:
            break;
    }
}



- (void)notifyUserOfCameraAccessDenial {
    // display a useful message asking the user to grant permissions from within Settings > Privacy > Camera
}

@end

@implementation ScannerController{
  
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    BOOL _trackCameraPosition;
    NSObject<FlutterPluginRegistrar>* _registrar;
    BOOL _cameraDidInitialSetup;

}
- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  if (self = [super init]) {
    _viewId = viewId;


      
      
      
    
      
   

      
      
    _trackCameraPosition = NO;
//    InterpretMapOptions(args[@"options"], self);
    NSString* channelName =
        [NSString stringWithFormat:@"document_scanner"];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName
                                           binaryMessenger:registrar.messenger];
      

      
//      _scannerView = [DocumentScannerView new];
     _scannerView = [[DocumentScannerView alloc] initWithChannel:_channel];

    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      if (weakSelf) {
//        [weakSelf onMethodCall:call result:result];
      }
    }];
//    _mapView.delegate = weakSelf;
    _registrar = registrar;
    _cameraDidInitialSetup = NO;
      
      float channelBrightness = 0;
      float channelContrast = 0;

      id brightness = args[@"brightness"];
      if ([brightness isKindOfClass:[NSNumber class]]){
          channelBrightness = [brightness floatValue];
         
      }else{
          channelBrightness = 5;
      }
      id contrast = args[@"contrast"];
        if ([contrast isKindOfClass:[NSNumber class]]){
            channelContrast = [contrast floatValue];
        }else{
            channelContrast = 1.3;
        }
     
      
//            _scannerView = [[DocumentScannerView alloc] initWithChannel:_channel brightness:channelBrightness contrast:channelContrast];

      //    id polygonsToAdd = args[@"polygonsToAdd"];
//    if ([polygonsToAdd isKindOfClass:[NSArray class]]) {
////      [_polygonsController addPolygons:polygonsToAdd];
//    }
//    id polylinesToAdd = args[@"polylinesToAdd"];
//    if ([polylinesToAdd isKindOfClass:[NSArray class]]) {
////      [_polylinesController addPolylines:polylinesToAdd];
//    }
//    id circlesToAdd = args[@"circlesToAdd"];
//    if ([circlesToAdd isKindOfClass:[NSArray class]]) {
////      [_circlesController addCircles:circlesToAdd];
//    }
  }
    
  return self;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}







//
//UIButton *createButton(CGFloat x, CGFloat y, CGFloat width, CGFloat height, NSString *caption, NSTextAlignment textPosition, UIColor *textColor, UIColor *backColor) {
//    UIButton *control = [[UIButton alloc] initWithFrame: CGRectMake(x, y, width, height)];
//    [control setTitle:caption forState:UIControlStateNormal];
//    control.titleLabel.textAlignment = textPosition;
//    control.backgroundColor = backColor;
//    [control setTitleColor: textColor forState:UIControlStateNormal];
//    return control;
//}






- (nonnull UIView *)view {

    return _scannerView;
}

@end




