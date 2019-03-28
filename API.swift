
//
//  API.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 25/12/17.
//  Copyright © 2017 Vinay Shankar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class API: NSObject {
    
    
    var view:UIView?
    class func login(email:String,mobile:String, password:String,otp:String, deviceToken:String, IMEI:String,deviceType:String,registerFlow:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){

        var authKey = Helpder.getAuthKey()
        if authKey == nil {
            authKey = ""
        }
        let url = Constants.WebService.login
        let parameters = ["email":email,
                          "mobile":mobile,
                          "password":password,
                          "otp":  otp,
                          "deviceToken":  deviceToken,
                          "deviceType":  deviceType,
                          "unique_id":  IMEI,
                          "registerFlow": registerFlow,
                          "authKey": authKey! as Any,
        ] as [String: Any]
      
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
            .authenticate(user: email, password: password)
            .responseJSON { response in
            
            switch response.result {
            case .failure(let error):
                completion(error, false)
                print(error)
            break
            case .success(let value):
                
                if response.result.value is NSNull{
                    return
                }else {
                    
                    
                    var json = JSON(value)
                    
                    let successKey = json["success"].bool ?? false
                    let message = json["message"].string ?? ""
                    Helpder.saveMessage(code: message)
                    if successKey == false {
                        completion(nil, false)
                        //ANLoader.hide()
                    }else {
                        let authKy = json["authKey"].string ?? ""
                        let username = json["email"].string ?? ""
                        let pred = json["predPoint"].string ?? ""
                        let cred = json["credPoint"].string ?? ""
                        let refer = json["referralCode"].string ?? ""
                        
                        let email = json["email"].string ?? ""
                        let logincount = json["loginCount"].int ?? 0
                        
                        let userId = json["userId"].string ?? ""
                        let useCredsOnly = json["useCredsOnly"].bool ?? false
                        Helpder.saveUserCred(userCred: useCredsOnly)
                        Helpder.saveUserId(userId: userId)
                        Helpder.saveAuthKey(auth: authKy)
                        Helpder.saveUsername(userName: username)
                        Helpder.savePred(pred: pred)
                        Helpder.saveEmail(userName: email)
                        Helpder.saveCred(cred: cred)
                        Helpder.saveReferralCode(referral: refer)
                        Helpder.saveLoginCount(loginCount: logincount)
                        completion(nil, true)
                        

                       
                    }
                    
                   
                }
            
            
            }
            
        }
    }
    
    class func Skiplogin(deviceToken:String, IMEI:String,deviceType:String,registerFlow:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let authKey = Helpder.getAuthKey()
        let url = Constants.WebService.guestLogin
        let parameters = ["deviceToken":  deviceToken,
                          "deviceType":  deviceType,
                          "unique_id":  IMEI,
                          "registerFlow": registerFlow,
                          "authKey": authKey as Any
        ] as [String: Any]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
            .responseJSON { response in
                
                switch response.result {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                    break
                case .success(let value):
                    
                    if response.result.value is NSNull{
                        return
                    }else {
                        
                        var json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                            let Alert = Util.alert()
                            
                            Alert.msg(message: message, title: "Warning!")
                            //ANLoader.hide()
                        }else {
                            let authKy = json["authKey"].string ?? ""
                            let username = json["email"].string ?? ""
                            let pred = json["predPoint"].string ?? ""
                            let cred = json["credPoint"].string ?? ""
                            let refer = json["referralCode"].string ?? ""
                            
                            let email = json["email"].string ?? ""
                            let logincount = json["loginCount"].int ?? 0
                            let userId = json["userId"].string ?? ""
                            UserDefaults.standard.set(true, forKey: "guestUser")
                            UserDefaults.standard.synchronize()
                            Helpder.saveUserId(userId: userId)
                            Helpder.saveAuthKey(auth: authKy)
                            Helpder.saveUsername(userName: username)
                            Helpder.savePred(pred: pred)
                            Helpder.saveEmail(userName: email)
                            Helpder.saveCred(cred: cred)
                            Helpder.saveReferralCode(referral: refer)
                            Helpder.saveLoginCount(loginCount: logincount)
                            completion(nil, true)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    
    
    class func ApplyCoupon(coupon:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.getSetting
        
        guard let authKey = Helpder.getAuthKey() else {return}
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey,
                              "couponCode":coupon]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        var json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                            
                            //ANLoader.hide()
                            completion(nil, false)
                        }else {
                            completion(nil, true)
                        }
                        
                    }
            }
        }
        
        
    }
    
    class func SubmitReferral(referralCode:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.submitReferral
        
        guard let authKey = Helpder.getAuthKey() else {return}
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey,
                              "referralCode":referralCode]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        var json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                            let message = Helpder.getMessage()
                            let Alert = Util.alert()
                            Alert.msg(message: message!, title: "Warning!")
                            completion(nil, false)
                        }else {
                            let successText = json["successText"].string ?? ""
                            let Alert = Util.alert()
                            Alert.msg(message: successText, title: "")
                            completion(nil, true)
                        }
                    }
            }
        }
        
        
    }
    
    class func getSetting(completion: @escaping (_ error:Error?, _ success:Bool, _ categoryIcons:[CategoryIcons]?)->Void){
        let url = Constants.WebService.getSetting
        var authKey = Helpder.getAuthKey()
        if authKey == nil {
            authKey = ""
        }
        let connstatus = Util.Connectivity.isConnectedToInternet()
        
        let device = Util.getUDIDCode()
        let deviceToken = Helpder.getDeviceToken()
        let isFirst = Helpder.getFirstFlow()
       
        if(!connstatus)
        {
            let Alert = Util.alert()
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
            completion(nil, false, nil)
        }else {
            let parameters = ["unique_id":device,
                              "deviceToken":deviceToken as Any,
                              "deviceType":"ios",
                              "isFirstRun": isFirst as Any,
                              "authKey": authKey! as Any] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        completion(error, false, nil)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                            
                            //ANLoader.hide()
                            completion(nil, false, nil)
                        }else {
                            var categoryList1 = [CategoryIcons]()
                            
                            if let sections = json["data"].dictionary {
                                let registerFlow = sections["registerFlow"]?.string ?? ""
                                Helpder.saveRegisterFlow(flow: registerFlow)
                                
                            }
                            guard let dataArr = json["data"]["categoryData"].array else {
                                return
                            }
                            
                            for data in dataArr {
                                guard let data1 = data.dictionary else {return}
                                let list = CategoryIcons()
                                list.name = data1["name"]?.string ?? ""
                                list.icon = data1["icon"]?.string ?? ""
                                
                                categoryList1.append(list)
                            }
                            
                            completion(nil, true, categoryList1)
                        }
                    }
            }
        }
        
        
    }
    
    class func referralCode(email:String, mobile: String, referral: String, completion: @escaping (_ error:Error?, _ success:Bool,  _ invalid:[String]? )->Void){
        let url = Constants.WebService.validateUser
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["email":email,
                              "mobile":mobile,
                              "referralCode":referral
                            ] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        completion(error, false, nil)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        let message = json["message"].string ?? ""
                        var invalidString = [String]()
                        Helpder.saveMessage(code: message)
                        if message == "InValid!" {
                            guard let invalid = json["invalid"].array else {
                                return
                            }
                            
                            for data in invalid {
                                let data = data.string
                                invalidString.append(data!)
                            }
                            completion(nil, false, invalidString)
                        }else {
                            
                            
                            completion(nil, true, invalidString)
                        }
                    }
            }
        }
        
        
    }
    
    class func OTP(email:String, mobileno:String,otpFor:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.OTP
       // let device = Util.getUDIDCode()
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["email":email,
                          "mobile":mobileno,
                          "otpFor":otpFor]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        let json = JSON(value)
                        
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                           // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                            completion(nil, false)
                        }else {
                            let otp = json["otp"].string ?? ""
                            let otpFor = json["otpFor"].string ?? ""
                            Helpder.saveOTP(OTP: otp)
                            Helpder.saveOTPFor(OTPfor: otpFor)
                            completion(nil, true)
                            
                        }
                        
                    }
                    
            }
        }
        
    }
    
    class func updateLogo(file:String,completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.updateLogo
        // let device = Util.getUDIDCode()
        guard let authKey = Helpder.getAuthKey() else {return}
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["authKey":authKey,
                          "file":file]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                           // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                        }else {
                            
                            
                            completion(nil, true)
                           
                        }
                        
                        }
                        
                    }
                    
            }
        
        
    }
    class func updateProductLogo(file:String,productId:String,completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.updateProductLogo
        // let device = Util.getUDIDCode()
        guard let authKey = Helpder.getAuthKey() else {return}
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["authKey":authKey,
                          "file":file,
                          "productId":productId]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                            // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                        }else {
                            
                            
                            completion(nil, true)
                            
                        }
                        
                    }
                    
            }
            
        }
        
        
    }
    class func Register(email:String, password:String,type:String, mobile:String, otp:String, userLat:String,userLong:String,IMEI:String, deviceToken:String, deviceType:String,  imageURL:String,registerFlow:String,referralCode:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.register
        var authKey = Helpder.getAuthKey()
        if authKey == nil {
            authKey = ""
        }
        
        var guestUser = Helpder.getGuestRegister()
        if guestUser == nil {
            guestUser = false
        }
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["email":email,
                          "password":password,
                          "type":type,
                          "mobile":mobile,
                          "otp":otp,
                          "userLat":"",
                          "userLong":"",
                          "unique_id":IMEI,
                          "deviceToken":deviceToken,
                          "deviceType":deviceType,
                          "imageURL": imageURL,
                          "registerFlow":registerFlow,
                          "referralCode":referralCode,
                          "authKey":authKey! as Any,
                          "isGuestRegister":guestUser] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        
                        let json = JSON(value)
                        
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                           // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                        }else {
                            let authKy = json["authKey"].string ?? ""
                            let logincount = json["loginCount"].int ?? 0
                            let refer = json["referralCode"].string ?? ""
                            let pred = json["predPoint"].string ?? ""
                            let cred = json["credPoint"].string ?? ""
                            let userId = json["userId"].string ?? ""
                            Helpder.saveUserId(userId: userId)
                            Helpder.saveAuthKey(auth: authKy)
                            Helpder.saveLoginCount(loginCount: logincount)
                            Helpder.saveReferralCode(referral: refer)
                            Helpder.savePred(pred: pred)
                            Helpder.saveCred(cred: cred)
                            completion(nil, true)
                        }
                        
                        
                    }
                    
            }
        }
        
    }
   
   
    
    class func postEditProfileMethod(name:String, mobile:String,gender:String, age:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.updateProfile
        guard let authKey = Helpder.getAuthKey() else {return}
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = [ "authKey":authKey,
                           "type":"all",
                           "fullName" :name,
                           "mobile":mobile,
                           "gender":gender,
                           "age":age] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        
                        let json = JSON(value)
                        
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                        }else {
                           
                            completion(nil, true)
                        }
                        
                        
                    }
                    
            }
        }
        
    }
    class func setPredict(teamName:String, matchId:String, stakePred:String, matchType:String, returnSize:String, predictType:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.setPredict
        guard let authKey = Helpder.getAuthKey() else {return}
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["authKey":authKey,
                          "teamName":teamName,
                          "matchId":matchId,
                          "stakePred":stakePred,
                          "matchType":matchType,
                          "returnSize":returnSize,
                          "predictType":predictType] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: params,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        
                        let json = JSON(value)
                        
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                           // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message:message, title: "Warning!")
                        }else {
                            
                            completion(nil, true)
                        }
                        
                        
                    }
                    
            }
        }
        
    }
    
    class func CricketList(completion: @escaping (_ error: Error?, _ cricket:[CricketClass]?)-> Void){
        
        let url = Constants.WebService.predictCentre
        let authKey = "5b3dd4fb8b6ba_H9PX"
//        guard let authKey = Helpder.getAuthKey() else{
//            completion(nil, nil)
//            return
//        }
        print(authKey)
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        //ANLoader.hide()
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        guard let dataArr = json["cricketList"].array else {
                            completion(nil, nil)
                           // ANLoader.hide()
                            return
                        }
                        
                        
                        var cricket = [CricketClass]()
                        for data in dataArr {
                            guard let data = data.dictionary else {return}
                            
                            let cricketList = CricketClass()
                            cricketList.teamName = data["teamName"]?.string ?? ""
                            cricketList.isChecked = data["isChecked"]?.bool ?? false
                            cricketList.flag = data["flag"]?.string ?? ""
                            
                            cricket.append(cricketList)
                        }
                        completion(nil, cricket)
                        
                        break
                        
                    }
                    
            }
        }
        
        
    }
    
   
    
    
   
    class func getPredictCentre(completion: @escaping (_ error: Error?, _ predict:[PredictData]?, _ section:[PredictData]?, _ matches:[Matches]?)-> Void){
        
        let url = Constants.WebService.predictCentre
                guard let authKey = Helpder.getAuthKey() else{
                    completion(nil,nil,nil,nil)
                    return
                }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey,
                              "type":"all"]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        guard let dataArr = json["data"].array else {
                            completion(nil, nil, nil, nil)
                            return
                        }
                        
                        var predict = [PredictData]()
                        var matchData = [Matches]()
                        var sectionData = [PredictData]()
                        for data in dataArr {
                            
                            if let sections = data["league_name"].dictionary {
                                let sectionList = PredictData()
                                sectionList.league_name = sections["league_name"]?.string ?? ""
                                
                                sectionData.append(sectionList)
                            }
                            if let matches = data["matches"].dictionary {
                                
                                let matchList = Matches()
                                matchList.cardType = matches["cardType"]?.string ?? ""
                                matchList.matchId = matches["matchId"]?.string ?? ""
                                matchList.teamA = matches["teamA"]?.string ?? ""
                                matchList.teamB = matches["teamB"]?.string ?? ""
                                matchList.competitionName = matches["competitionName"]?.string ?? ""
                                matchList.competitionImage = matches["competitionImage"]?.string ?? ""
                                matchList.matchType = matches["matchType"]?.string ?? ""
                                matchList.matchLabel = matches["matchLabel"]?.string ?? ""
                                matchList.date = matches["date"]?.string ?? ""
                                matchList.countDown = matches["countDown"]?.string ?? ""
                                matchList.teamALogo = matches["teamALogo"]?.string ?? ""
                                matchList.teamBLogo = matches["teamBLogo"]?.string ?? ""
                                matchList.teamAPercent = matches["teamAPercent"]?.int ?? 0
                                matchList.teamBPercent = matches["teamBPercent"]?.int ?? 0
                                matchList.drawPercent = matches["drawPercent"]?.int ?? 0
                                matchList.teamACoefficient = matches["teamACoefficient"]?.string ?? ""
                                matchList.teamBCoefficient = matches["teamBCoefficient"]?.string ?? ""
                                matchList.drawCoefficient = matches["drawCoefficient"]?.string ?? ""
                                matchList.returnSize = matches["returnSize"]?.string ?? ""
                                matchList.competitionImage = matches["competitionImage"]?.string ?? ""
                                matchList.competitionImage = matches["competitionImage"]?.string ?? ""
                                
                                matchData.append(matchList)
                                
                            }else {
                                return
                            }
                            guard let data = data.dictionary else {return}
                            
                            let predictList = PredictData()
                            predictList.league_name = data["league_name"]?.string ?? ""
                            predictList.matches = data["matches"]?.arrayObject as? [Matches]
                            
                            
                            predict.append(predictList)
                        }
                        completion(nil, predict, sectionData, matchData)
                        
                        break
                        
                    }
                    
            }
        }
        
        
    }
    
    /*class func getLeaderBoardAPI(completion: @escaping (_ error: Error?, _ leaderBoard:[LeaderBoard]?, _ leaders:[LeaderBoard]?,  _ sliderData:[SliderData]?)-> Void){
        
        let url = Constants.WebService.leaderBoard
                guard let authKey = Helpder.getAuthKey() else{
                    completion(nil, nil,nil, nil)
                    return
                }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        completion(nil, nil, nil, nil)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        guard let dataArr = json["data"].array else {
                            completion(nil, nil, nil, nil)
                            return
                        }
                        
                        var leaders = [LeaderBoard]()
                        if let myDataArr = json["myData"].dictionary {
                            let leaderList = LeaderBoard()
                            leaderList.email = myDataArr["email"]?.string ?? ""
                            leaderList.imageURL = myDataArr["imageURL"]?.string ?? ""
                            leaderList.credPoint = myDataArr["credPoint"]?.int ?? 0
                            leaderList.userType = myDataArr["userType"]?.string ?? ""
                            leaderList.rank = myDataArr["rank"]?.int ?? 0
                            leaderList.userName = myDataArr["userName"]?.string ?? ""
                            leaderList.isPrize = myDataArr["isPrize"]?.bool ?? false
                            leaderList.prizeTitle = myDataArr["prizeTitle"]?.string ?? ""
                            
                            leaders.append(leaderList)
                            
                        } else {
                            completion(nil, nil, nil, nil)
                            return
                        }
                        
                        guard  let sliderDataArr = json["sliderData"].array else {
                            completion(nil, nil, nil, nil)
                            return
                        }
                        
                        var leader = [LeaderBoard]()
                        var sliderData = [SliderData]()
                        for data in dataArr {
                            guard let data = data.dictionary else {return}
                            
                            let leaderList = LeaderBoard()
                            leaderList.email = data["email"]?.string ?? ""
                            leaderList.imageURL = data["imageURL"]?.string ?? ""
                            leaderList.credPoint = data["credPoint"]?.int ?? 0
                            leaderList.userType = data["userType"]?.string ?? ""
                            leaderList.rank = data["rank"]?.int ?? 0
                            leaderList.userName = data["userName"]?.string ?? ""
                            
                            
                            leader.append(leaderList)
                        }
                        
                        for data in sliderDataArr {
                            guard let data = data.dictionary else {return}
                            
                            let sliderList = SliderData()
                            sliderList.sliderType = data["sliderType"]?.string ?? ""
                            sliderList.sliderImage = data["sliderImage"]?.string ?? ""
                            sliderList.sliderLink = data["sliderLink"]?.string ?? ""
                            sliderList.isInternal = data["isInternal"]?.bool ?? false
                            sliderList.internalId = data["internalId"]?.int ?? 0
                            sliderList.sliderId = data["sliderId"]?.string ?? ""
                            
                            sliderData.append(sliderList)
                            
                        }
                        completion(nil, leader, leaders, sliderData)
                        
                        break
                        
                    }
                    
            }
        }
        
        
    }*/
    
    class func getEarnings(completion: @escaping ( _ error: Error?,  _ success:Bool?,  _ referalListData:[ReferalList]?,  _ referrarData:ReferrarData?, _ referalData:ReferalData?)-> Void){
        
        let url = Constants.WebService.earningData
        guard let authKey = Helpder.getAuthKey() else {
            completion(nil, false, nil, nil,nil)
            return
        }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        
                        guard let dataArr1 = json["Data"]["referralList"].array else {
                            completion(nil, false, nil, nil,nil)
                            return
                        }
                        guard let dataArr2 = json["Data"].dictionary else {return}
                        guard let dataArr3 = json["Data"]["referrarData"].dictionary else {return}
                        let referalData = ReferalData()
                        referalData.totalReferral = dataArr2["totalReferral"]?.int ?? 0
                        referalData.payoutTerms = dataArr2["payoutTerms"]?.string ?? ""
                        referalData.totalRsEarned = dataArr2["totalRsEarned"]?.string ?? ""
                        referalData.totalPredsEarned = dataArr2["totalPredsEarned"]?.string ?? ""
                        referalData.referralCode = dataArr2["referralCode"]?.string ?? ""
                        referalData.referralText = dataArr2["referralText"]?.string ?? ""
                        
                        let referrarData = ReferrarData()
                        referrarData.creds = dataArr3["creds"]?.int ?? 0
                        referrarData.preds = dataArr3["preds"]?.int ?? 0
                        referrarData.email = dataArr3["email"]?.string ?? ""
                        referrarData.scheme = dataArr3["scheme"]?.string ?? ""
                        
                        var tab = [ReferalList]()
                        for data in dataArr1 {
                            guard let data = data.dictionary else {return}
                            
                            let tabs = ReferalList()
                            tabs.email = data["email"]?.string ?? ""
                            tabs.image = data["image"]?.string ?? ""
                            tabs.joinDate = data["joinDate"]?.string ?? ""
                            tabs.earnString = data["earnString"]?.string ?? ""
                            tabs.status = data["status"]?.string ?? ""
                            
                            tab.append(tabs)
                        }
                        completion(nil, false, tab, referrarData,referalData)
                        break
                        
                }
            }
        }
    }
    
    
    
    class func changePassword(email:String,  type:String, otp:String, password:String, authKey:String, completion: @escaping ( _ error:Error?,  _ success:Bool)->Void){
        let url = Constants.WebService.ChangePassword
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["email":email,
                              "type":type,
                              "otp":otp,
                              "password":password,
                              "authKey":authKey]
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        var json = JSON(value)
                        print(json)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                            // ANLoader.hide()
                            let Alert = Util.alert()
                            Alert.msg(message: message, title: "Warning!")
                            completion(nil, false)
                        }else {
                            
                            let data = json["data"].dictionary
                            if data == nil {
                                completion(nil, true)
                            }else {
                                let isPassword = data!["isPassword"]!.bool ?? false
                                UserDefaultClass.saveIsPassword(password: isPassword)
                                completion(nil, true)
                            }
                        }
                    }
            }
        }
    }
    
    class func redeemVoucher(id:String,  type:String, mobileNo:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.redeemVoucher
        guard let authKey = Helpder.getAuthKey() else {
            return
        }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey,
                              "voucherId":id,
                              "type":type,
                              "mobileNo":mobileNo]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        var json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        let code = json["code"].string ?? ""
                        Helpder.saveCode(code: code)
                        if successKey == false {
                            // ANLoader.hide()
                            let Alert = Util.alert()
                            
                            Alert.msg(message: message, title: "Warning!")
                           
                        }else {
                            
                            
                           completion(nil, true)
                        }
                        
                        
                    }
                    
                    
            }
        }
        
        
    }
    
   
    class func setFollwing(type:String, teamNames:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        let url = Constants.WebService.redeemVoucher
        guard let authKey = Helpder.getAuthKey() else {
            return
        }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey,
                              "teams":[type,teamNames]] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let _):
                        completion(nil, true)
                    }
                    
                    
            }
        }
        
        
    }
    
    func upload(image: UIImage, completion: (URL?) -> Void) {
        guard let data = UIImageJPEGRepresentation(image,0.9) else {
            return
        }
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            Alamofire.upload(multipartFormData: { (form) in
                form.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
            }, to:"https://predcred.com/v4/", encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseString { response in
                        print(response.value)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
        }
        
    }
    
    class func apiMultipart(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            for (key, value) in parameters! {
                if key == "file" {
                    multipartFormData.append(
                        value as! Data,
                        withName: key,
                        fileName: "swift_file.jpg",
                        mimeType: "image/jpg"
                    )
                } else {
                    //Data other than image
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
            }
        }, usingThreshold: 1, to: serviceName, method: .post, headers: ["Content-Type": "application/json"]) { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.error != nil {
                        completionHandler(nil,response.result.error as NSError?)
                        return
                    }
                    print(response.result.value!)
                    if let data = response.result.value {
                        let json = JSON(data)
                        completionHandler(json,nil)
                    }
                }
                break
                
            case .failure(let encodingError):
                print(encodingError)
                completionHandler(nil,encodingError as NSError?)
                break
            }
        }
    }
    
   
    class func getSupplyCenter(completion: @escaping ( _ error: Error?,  _ success:Bool?,  _ supplyCenterListData:suppliesCenterData?,  _ limitBoosterData:LimitBoosterData?,  _ returnBoosterData:returnboosterStirng?)-> Void){
        
        let url = Constants.WebService.getSupplyCenter
        guard let authKey = Helpder.getAuthKey() else {
            completion(nil, false, nil, nil,nil)
            return
        }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey] as [String : Any]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        guard let mainData = json["data"].dictionary else {return}
                        guard let limitData = json["data"]["limitBooster"].dictionary else {return}
                        guard let returnData = json["data"]["returnBooster"].dictionary else {return}
                        
                        
                        let mainDataStr = suppliesCenterData()
                        mainDataStr.credPoints = mainData["credPoints"]?.int ?? 0
                        mainDataStr.predPoints = mainData["predPoints"]?.int ?? 0
                        mainDataStr.limitBoosterValue = mainData["limitBoosterValue"]?.int ?? 0
                        mainDataStr.returnBoosterValue = mainData["returnBoosterValue"]?.int ?? 0
                        mainDataStr.watchVideo = mainData["watchVideo"]?.string ?? ""
                        mainDataStr.totalLimitBooster = mainData["totalLimitBooster"]?.int ?? 0
                        mainDataStr.totalReturnBooster = mainData["totalReturnBooster"]?.int ?? 0
                        mainDataStr.referEarnText = mainData["referEarnText"]?.string ?? ""
                        mainDataStr.referEarnText2 = mainData["referEarnText2"]?.string ?? ""
                        mainDataStr.spinTitle = mainData["spinTitle"]?.string ?? ""
                        mainDataStr.spinText = mainData["spinText"]?.string ?? ""
                        mainDataStr.spinDots = mainData["spinDots"]?.string ?? ""
                        mainDataStr.spinsLeft = mainData["spinsLeft"]?.string ?? ""
                        mainDataStr.spinPredictLeft = mainData["spinPredictLeft"]?.string ?? ""
                        mainDataStr.watchVideoText1 = mainData["watchVideoText1"]?.string ?? ""
                        mainDataStr.watchVideoText2 = mainData["watchVideoText2"]?.string ?? ""
                        mainDataStr.credsBidded = mainData["credsBidded"]?.string ?? ""
                        mainDataStr.credToPredValue = mainData["credToPredValue"]?.string ?? ""
                        mainDataStr.isBooster = mainData["isBooster"]?.bool ?? false
                        
                        let returndataStr = returnboosterStirng()
                        returndataStr.twoX = returnData["twoX"]?.int ?? 0
                        returndataStr.threeX = returnData["threeX"]?.int ?? 0
                        returndataStr.fourX = returnData["fourX"]?.int ?? 0
                        returndataStr.fiveX = returnData["fiveX"]?.int ?? 0
                        
                        let limitdataStr = LimitBoosterData()
                        limitdataStr.twoX = limitData["twoX"]?.int ?? 0
                        limitdataStr.threeX = limitData["threeX"]?.int ?? 0
                        limitdataStr.fourX = limitData["fourX"]?.int ?? 0
                        limitdataStr.fiveX = limitData["fiveX"]?.int ?? 0
                        
                        
                        
                        completion(nil, true, mainDataStr, limitdataStr,returndataStr)
                        
                        break
                    }
                    
            }
            
        }
        
    }
    
    class func getnotification(completion: @escaping (_ error: Error?, _ success:Bool?, _ newData:[NotificationData]? , _ earlierData:[NotificationData]?  )-> Void){
        
        let url = Constants.WebService.notification
        guard let authKey = Helpder.getAuthKey() else {
            completion(nil, false, nil, nil)
            return
        }
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": authKey] as [String : Any]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        
                        guard let dataArr1 = json["newData"].array else {
                            completion(nil, false, nil, nil)
                            return
                        }
                        guard let dataArr2 = json["earlierData"].array else {
                            completion(nil, false, nil, nil)
                            return
                        }
                        var newData = [NotificationData]()
                        var earlierData = [NotificationData]()
                        for data in dataArr1 {
                            guard let data = data.dictionary else {return}
                            let newList = NotificationData()
                            
                            newList.title = data["title"]?.string ?? ""
                            newList.image = data["image"]?.string ?? ""
                            newList.time_ago = data["time_ago"]?.string ?? ""
                            newList.notifType = data["notifType"]?.string ?? ""
                            newList.redirectScreen = data["redirectScreen"]?.string ?? ""
                            if let data1 = data["popupData"]?.dictionary {
                                newList.popupData.text = data1["text"]?.string ?? ""
                            }
                            if let data2 = data["data"]?.dictionary {
                                newList.data.id = data2["id"]?.string ?? ""
                                newList.data.roundNumber = data2["roundNumber"]?.int ?? 0
                                newList.data.type = data2["type"]?.string ?? ""
                            }
                            newData.append(newList)
                        }
                        
                        for data in dataArr2 {
                            guard let data = data.dictionary else {return}
                            let earlierList = NotificationData()
                            
                            earlierList.title = data["title"]?.string ?? ""
                            earlierList.image = data["image"]?.string ?? ""
                            earlierList.time_ago = data["time_ago"]?.string ?? ""
                            earlierList.notifType = data["notifType"]?.string ?? ""
                            earlierList.redirectScreen = data["redirectScreen"]?.string ?? ""
                            if let data1 = data["popupData"]?.dictionary {
                                earlierList.popupData.text = data1["text"]?.string ?? ""
                            }
                            if let data2 = data["data"]?.dictionary {
                                earlierList.data.id = data2["id"]?.string ?? ""
                                earlierList.data.roundNumber = data2["roundNumber"]?.int ?? 0
                                earlierList.data.type = data2["type"]?.string ?? ""
                            }
                            earlierData.append(earlierList)
                        }
                        completion(nil, true, newData, earlierData)
                        break
                    }
                    
            }
            
        }
    }

    class func getUserInfo(authKey:String, completion: @escaping ( _ error:Error?,  _ success:Bool)->Void){
        let url = Constants.WebService.getUserInfo
        guard let authKey = Helpder.getAuthKey() else {
            return
        }
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        var json = JSON(value)
                        print(json)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        if successKey == false {
                            // ANLoader.hide()
                            let Alert = Util.alert()
                            Alert.msg(message: message, title: "Warning!")
                            
                        }else {
                            let data = json["data"].dictionary
                            let isPassword = data!["isPassword"]!.bool ?? false
                            let email = data!["email"]!.string ?? ""
                            let mobile = data!["mobileNumber"]!.string ?? ""
                            UserDefaultClass.saveSettingEmail(email: email)
                            UserDefaultClass.saveSettingMobile(mobile: mobile)
                            UserDefaultClass.saveIsPassword(password: isPassword)
                            completion(nil, true)
                        }
                    }
            }
        }
    }
    
    class func setPassword(authKey:String,  Password:String, completion: @escaping ( _ error:Error?,  _ success:Bool)->Void){
        let url = Constants.WebService.setPassword
        guard let authKey = Helpder.getAuthKey() else {
            return
        }
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey":authKey,
                              "Password":Password,
                              ]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                
                .responseJSON { response in
                    
                    switch response.result {
                    case .failure(let error):
                        completion(error, false)
                        print(error)
                        break
                    case .success(let value):
                        
                        var json = JSON(value)
                        
                        completion(nil, true)
                    }
            }
        }
    }

}

