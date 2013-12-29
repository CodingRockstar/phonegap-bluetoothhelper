//
// BluetoothHelper.h
// BluetoothHelper
//
// Created by Stephan Jahrling.
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface BluetoothHelper : CDVPlugin {
     UIWebView *webView;
}

- (BluetoothHelper*)pluginInitialize;
- (BOOL) isLECapableHardware;
@end