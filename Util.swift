//
//  Util.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 14/11/17.
//  Copyright © 2017 Vinay Shankar. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import Contacts
import ContactsUI
import SwiftKeychainWrapper

class Util: NSObject {
    
    
   
    
    class func getPath(fileName: String) -> String {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsURL)
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName: fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if (error != nil) {
                print(error?.localizedDescription ?? AnyObject.self)
            } else {
                print("Your database copy successfully")
            }
            
        }
    }
    
    class func invokeAlertMethod(strTitle: NSString, strBody: NSString, delegate: AnyObject? ,vcobj : UIViewController ) {
        let alert = UIAlertController(title: strTitle as String, message:strBody as String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in })
        
        let popOver = alert.popoverPresentationController
        popOver?.sourceView  = vcobj.view
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        vcobj.present(alert, animated: true){}
    }
    class func showAlert(vcobj : UIViewController ) {
        let alert = UIAlertController()
        alert.addChildViewController(vcobj)
        
        let popOver = alert.popoverPresentationController
        popOver?.sourceView  = vcobj.view
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        vcobj.present(alert, animated: true){}
    }
    
    class alert {
        
        let container: UIView = UIView()
        let view :UIView = UIView()
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        func msg(message: String, title: String = "")
        {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
          // UtilClass().hideActivityIndicator(uiView:self.view,"Loading...")
        }
        
        func hideActivityIndicator(uiView: UIView,_ title: String)
        {
            activityIndicator.stopAnimating()
            container.removeFromSuperview()
        }
    }
    
    
   
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class Connectivity {
        class func isConnectedToInternet() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    class func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
   class func phoneNumberValidation(value: String) -> Bool {
    let character = NSCharacterSet(charactersIn: "0123456789").inverted
    var filtered:String!
    let inputStrig:NSArray = value.components(separatedBy: character) as NSArray
    filtered = inputStrig.componentsJoined(by: "")
    return  value == filtered
    }
    class func ValidateMobileNumber(txtFeid : UITextField, strChk : String, range: NSRange) -> Bool {
        
        if txtFeid.text!.count >= 10 {
            return false
        }
        
        let formatePre = "^((\\+)|(00))[0-9]{6,14}$"
        let resultPredicate : NSPredicate = NSPredicate(format: "SELF MATCHES %@",formatePre)
        return resultPredicate.evaluate(with: strChk)
    }
    class func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z])$")
        return passwordTest.evaluate(with: password)
    }
    
    class func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    class func isPwdLenth(password: String , confirmPassword : String) -> Bool {
        if password.count <= 7 && confirmPassword.count <= 7{
            
            return true
        }else{
            return false
        }
    }
    class func FunLogout()
    {
        
        let kOfMobileNumber = UserDefaults.standard.string(forKey: "kOfMobileNumber")
        print(kOfMobileNumber ?? AnyObject.self)
        
      /*  if (kOfMobileNumber==Constants.Login.demologin){
            ModelManager.getInstance().deleteInfo()
            
        }
        */
        
        
        
        UserDefaults.standard.removeObject(forKey: "kOfUserId")
        UserDefaults.standard.synchronize()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "NavViewController") as! UINavigationController
        let appDel = UIApplication.shared.delegate! as! AppDelegate
        appDel.window?.rootViewController = initialViewController
        appDel.window?.makeKeyAndVisible()
    }
    
    
    class func presentSettingsActionSheet(vcobj:UIViewController) {
        let settingsActionSheet: UIAlertController = UIAlertController(title:"Choose Option", message:nil, preferredStyle:UIAlertController.Style.actionSheet)
        
        //   settingsActionSheet.view.tintColor = UIColor.()
        
        
        settingsActionSheet.addAction(UIAlertAction(title:"Logout", style:UIAlertAction.Style.default, handler:{ action in
            //call logout
            Util.FunLogout()
        }))
        settingsActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertAction.Style.cancel, handler:nil))
        
        
        //settingsActionSheet.popoverPresentationController!.sourceView = vcobj.view
        //settingsActionSheet.popoverPresentationController!.sourceRect = vcobj.view.bounds        // this is the center of the screen currently but it can be any point in the view
        
        let popOver = settingsActionSheet.popoverPresentationController
        popOver?.sourceView  = vcobj.view
        // popOver?.sourceRect = vcobj.view.bounds
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        vcobj.present(settingsActionSheet, animated:true, completion:nil)
    }
    
    class func setCustomFont() -> CGFloat {
        
        //Current runable device/simulator width find
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // basewidth you have set like your base storybord is IPhoneSE this storybord width 320px.
        let baseWidth: CGFloat = 360
        
        // "14" font size is defult font size
        let fontSize = 14 * (width / baseWidth)
        
        return fontSize
    }
    
    class func setCustomFont1() -> CGFloat {
        
        //Current runable device/simulator width find
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // basewidth you have set like your base storybord is IPhoneSE this storybord width 320px.
        let baseWidth: CGFloat = 375
        
        // "14" font size is defult font size
        let fontSize = 18 * (width / baseWidth)
        
        return fontSize
    }
    class func setCustomFont2() -> CGFloat {
        
        //Current runable device/simulator width find
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        // basewidth you have set like your base storybord is IPhoneSE this storybord width 320px.
        let baseWidth: CGFloat = 375
        
        // "14" font size is defult font size
        let fontSize = 77 * (width / baseWidth)
        
        return fontSize
    }
    class func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        
        return components.day!
    }
    
    
    class func dateConvert(format1:String,format2:String,datetoconvert:String)->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format1
        let date = dateFormatter.date(from: datetoconvert)! as NSDate
        dateFormatter.dateFormat = format2
        return dateFormatter.string(from: date as Date)
        
    }
    
    class func getUDIDCode()->String
    {
        var deviceUDID = UIDevice.current.identifierForVendor?.uuidString
        KeychainWrapper.standard.set(deviceUDID!, forKey: "CurrentDeviceId")
       
        if let kOfMobileNumber = UserDefaults.standard.string(forKey: "kOfMobileNumber")
        {
            if(kOfMobileNumber==Constants.Login.demologin)
            {
                deviceUDID = Constants.Login.demodeviceUDID
            }
        }
        return deviceUDID!
    }
    
    func delay(seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: popTime + 42.0) {
            completion()
        }
    }
    
    
    func miliSecFromDate(date : String) -> TimeInterval {
        let strTime = date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd hh:mm:ss"
        let ObjDate = formatter.date(from: strTime)
        return (ObjDate?.timeIntervalSinceNow)!
    }
    
    
    
    
}

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
}
}
