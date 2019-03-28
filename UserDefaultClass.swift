//
//  UserDefaultClass.swift
//  PredCred
//
//  Created by JustMac on 2/5/19.
//  Copyright © 2019 Bhushan Nandan. All rights reserved.
//

import UIKit

class UserDefaultClass: NSObject {

    //Save value to userDefault
    class func saveIsPassword(password:Bool){
        let user = UserDefaults.standard
        
        user.setValue(password, forKey: "isPassword")
        user.synchronize()
    }
    class func saveSettingEmail(email:String){
        let user = UserDefaults.standard
        
        user.setValue(email, forKey: "email")
        user.synchronize()
    }
    class func saveSettingMobile(mobile:String){
        let user = UserDefaults.standard
        
        user.setValue(mobile, forKey: "mobileNumber")
        user.synchronize()
    }
    class func saveTournamentId(mobile:String){
        let user = UserDefaults.standard
        user.setValue(mobile, forKey: "cardId")
        user.synchronize()
    }
    class func savePredictTool(mobile:Bool){
        let user = UserDefaults.standard
        user.setValue(mobile, forKey: "firstPredict")
        user.synchronize()
    }
    class func saveSortDate(mobile:Bool){
        let user = UserDefaults.standard
        user.setValue(mobile, forKey: "sortDate")
        user.synchronize()
    }
    class func saveCategoryType(mobile:String){
        let user = UserDefaults.standard
        user.setValue(mobile, forKey: "categoryType")
        user.synchronize()
    }
    class func saveTournamentVC(mobile:Bool){
        let user = UserDefaults.standard
        user.setValue(mobile, forKey: "tournament")
        user.synchronize()
    }
    //get user default value
    class func getTournamentVC() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "tournament") as? Bool
    }
    class func getCategoryType() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "categoryType") as? String
    }
    class func getSortDate() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "sortDate") as? Bool
    }
    class func getIsPassword() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isPassword") as? Bool
    }
    class func getSettingEmail() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    class func getSettingMobile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "mobileNumber") as? String
    }
    class func getTournamentId() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "cardId") as? String
    }
    class func getPredictTool() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "firstPredict") as? Bool
    }
}
