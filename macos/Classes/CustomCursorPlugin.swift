import Cocoa
import FlutterMacOS

public class CustomCursorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "custom_cursor", binaryMessenger: registrar.messenger)
    let instance = CustomCursorPlugin()
      
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "activateCustomCursor":
      if let arguments = call.arguments as? [String: Any?] {
        if let bytes = arguments["bytes"] as? FlutterStandardTypedData {
            let image = NSImage(data: bytes.data)

            let hotSpot = NSPoint(x: 0.0, y: 0.0);
            let aCursor = NSCursor(image: image!, hotSpot:  hotSpot)
        // let aCursor = NSCursor.pointingHand;
            aCursor.set();
          }
      }
    
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
