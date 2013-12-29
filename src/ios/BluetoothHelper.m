#import <Cordova/CDV.h>
#import "BluetoothHelper.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface BluetoothHelper () <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager  *centralManager;


@end


@implementation BluetoothHelper

- (CDVPlugin*)initWithWebView:(UIWebView*)theWebView {
     self = [super initWithWebView:theWebView];
     if (self) {
          webView = theWebView;
     }
     return self;
}

- (BluetoothHelper*)pluginInitialize
{
     // bluetooth manager --> check if bluetooth is enabled
     _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
     
    return self;
}


#pragma mark - CBCentralManager delegate methods

/*
 Invoked whenever the central manager's state is updated.
 */
- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
     [self isLECapableHardware];
}


- (BOOL) isLECapableHardware
{
     NSString * state = nil;
     switch ([_centralManager state])
     {
          case CBCentralManagerStateUnsupported:
               state = @"CBCentralManagerStateUnsupported";
               break;
          
          case CBCentralManagerStateUnauthorized:
               state = @"CBCentralManagerStateUnauthorized";
               break;
          
          case CBCentralManagerStatePoweredOff:
               state = @"CBCentralManagerStatePoweredOff";
               break;
          
          case CBCentralManagerStatePoweredOn:
               state = @"CBCentralManagerStatePoweredOn";
               break;
               //return TRUE;
          
          case CBCentralManagerStateUnknown:
          default:
               state = @"CBCentralManagerStateUnknown";
               //return FALSE;
     }
     
     NSString* jsString = [NSString stringWithFormat:@"var evt = new CustomEvent('bluetoothUpdateState', {detail: {state: \"%@\"}}); document.dispatchEvent(evt);", state];
     [webView stringByEvaluatingJavaScriptFromString:jsString];
     
     // NSLog(@"Central manager state: %@", state);
     return FALSE;
}

- (void)isEnabled:(CDVInvokedUrlCommand*)command {
     
     // short delay so CBCentralManger can spin up bluetooth
     [NSTimer scheduledTimerWithTimeInterval:(float)0.2
                                      target:self
                                    selector:@selector(bluetoothStateTimer:)
                                    userInfo:[command.callbackId copy]
                                     repeats:NO];
     
     CDVPluginResult *pluginResult = nil;
     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
     [pluginResult setKeepCallbackAsBool:TRUE];
     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)bluetoothStateTimer:(NSTimer *)timer {
     
     // [self isLECapableHardware];
     
     
     NSString *callbackId = [timer userInfo];
     CDVPluginResult *pluginResult = nil;
     
     BOOL enabled = _centralManager.state == CBCentralManagerStatePoweredOn;
     
     if (enabled) {
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
     } else {
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsInt:_centralManager.state];
     }
     [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}