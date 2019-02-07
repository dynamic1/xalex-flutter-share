import Flutter
import UIKit

public class SwiftEsysFlutterSharePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "channel:github.com/orgs/esysberlin/esys-flutter-share", binaryMessenger: registrar.messenger())
        let instance = SwiftEsysFlutterSharePlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "shareImage"){
            self.shareImage(arguments: call.arguments)
        } else if(call.method == "shareText"){
            self.shareText(arguments: call.arguments)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    func shareImage(arguments:Any?) -> Void {
        // prepare method channel args
        let argsMap = arguments as! NSDictionary
        let fileName:String = argsMap.value(forKey: "fileName") as! String
        
	//let fileManager = NSFileManager.defaultManager()
	//let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
	//let documentDirectory: NSURL = urls.first as? NSURL
	//let finalDatabaseURL = documentDirectory.URLByAppendingPathComponent(fileName)
        
        
	
	//let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first 
	//let finalDatabaseURL = documentsPathURL.appendingPathComponent(fileName)

        // load the iage
        //let docsPath:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory,.userDomainMask , true).first!;
        let docsPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask , true).first!;
        let imagePath = NSURL(fileURLWithPath: docsPath).appendingPathComponent(fileName)
        let imageData:NSData? = NSData(contentsOf: imagePath!)
        //let imageToShare:UIImage = UIImage(data: imageData! as Data)!

	//NSLog("trying to share")
	//NSLog(fileName)
	//let fileURL = URL(fileURLWithPath: fileName)
        //let fileURL = NSURLfileURL(withPath:fileName)
	
	//let documento = NSData(contentsOfFile: fileName)
        
        // set up activity view controller
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [imageData], applicationActivities: nil)
        
        // present the view controller
        let controller = UIApplication.shared.keyWindow!.rootViewController as! FlutterViewController
        activityViewController.popoverPresentationController?.sourceView = controller.view

        controller.show(activityViewController, sender: self)
    }
    
    func shareText(arguments:Any?) -> Void {
        // prepare method channel args
        let argsMap = arguments as! NSDictionary
        let text:String = argsMap.value(forKey: "text") as! String
        
        // no use in ios
        //let title:String = argsMap.value(forKey: "title") as! String
        
        // set up activity view controller
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        // present the view controller
        let controller = UIApplication.shared.keyWindow!.rootViewController as! FlutterViewController
        activityViewController.popoverPresentationController?.sourceView = controller.view
        
        controller.show(activityViewController, sender: self)
    }
    
    
}
