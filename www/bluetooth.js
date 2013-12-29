var exec = require('cordova/exec');

/**
 * Constructor
 */
function BluetoothHelper() {
}

BluetoothHelper.prototype.isEnabled = function (success, failure) {
    cordova.exec(success, failure, "BluetoothHelper", "isEnabled", []);
};

module.exports = new BluetoothHelper();