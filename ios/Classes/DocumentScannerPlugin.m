#import "DocumentScannerPlugin.h"
#import "DocumentScannerView.h"
#import "DocumentScannerFactory.h"

@implementation DocumentScannerPlugin {
    NSObject<FlutterPluginRegistrar>* _registrar;
    FlutterMethodChannel* _channel;
    NSMutableDictionary* _mapControllers;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"document_scanner"
            binaryMessenger:[registrar messenger]];
  DocumentScannerPlugin* instance = [[DocumentScannerPlugin alloc] init];
     DocumentScannerFactory* factory = [[DocumentScannerFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:factory withId:@"document_scanner"];
//  [registrar addMethodCallDelegate:instance channel:channel];

}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
