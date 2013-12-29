Phonegap-Plugin for Bluetooth
========================

This is a helper-library for working with Phonegap (>= 3.0) and Bluetooth Low Energy (BLE). This library has only one method and fires an event, when Bluetooth-Status changes.

## Supported platforms

- iOS


## Installing

To use this plugin, add this to your project using the PhoneGap CLI:
```
phonegap local plugin add https://github.com/JahrlingSoftware/phonegap-bluetoothhelper.git
```

## Using the event
	
	document.addEventListener('bluetoothUpdateState', 
		function(e){
			
			if (e.detail.state == 'CBCentralManagerStatePoweredOff') {
    			...
    		}
    		else if (e.detail.state == 'CBCentralManagerStatePoweredOn') {
    			...
    		}
    		else {
    			...
    		}
			
		}, 
		false
	);

### State-values for Bluetooth-Connection

This event returns the status for the Bluetooth-Connection. These are the same as in `CBCentralManagerState` (-> [CBCentralManagerState](https://developer.apple.com/Library/ios/documentation/CoreBluetooth/Reference/CBCentralManager_Class/translated_content/CBCentralManager.html#//apple_ref/doc/c_ref/CBCentralManagerState))
Possible values are:
- CBCentralManagerStatePoweredOn
- CBCentralManagerStatePoweredOff
- CBCentralManagerStateUnknown
- CBCentralManagerStateUnsupported
- ...


## Available methods

### isEnabled
`BluetoothHelper.isEnabled(successCallback, errorCallback);` Is Bluetooth enabled (if true call successCallback, else call errorcallback)


## NOTE
The function for checkning the Bluetooth-state is taken from [https://github.com/don/BluetoothSerial](https://github.com/don/BluetoothSerial)

