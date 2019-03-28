//
//  APIList.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 29/03/18.
//  Copyright © 2018 PredCred. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class APIList:NSObject {
    
    

    class func getSetting(completion: @escaping (_ error: Error?,  _ blog:LivePredictor?)-> Void){
        
        let url = "https://api.predcred.com/v4/getSettings"
        
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let parameters = ["authKey": "predcred_settings_data"]
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .responseJSON { response in
                    switch response.result
                    {
                    case .failure(let error):
                        completion(nil, nil)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        
                        let livePredictor = LivePredictor()
                       if let tempVar = json["data"]["livePredictor"].dictionary {
                        
                        livePredictor.socketUrl = tempVar["socketUrl"]?.string ?? ""
                        livePredictor.liveTimer1 = tempVar["liveTimer1"]?.string ?? ""
                        livePredictor.liveTimer2 = tempVar["liveTimer2"]?.string ?? ""
                        livePredictor.liveTimer3 = tempVar["liveTimer3"]?.string ?? ""
                        livePredictor.showLeaderBoard = tempVar["showLeaderBoard"]?.bool ?? false
                        livePredictor.showHistory = tempVar["showHistory"]?.bool ?? false
                        
                        }
                       
                       // blog.append(livePredictor)
                        completion(nil, livePredictor)
                        
                        break
                        
                    }
            }
        }
    }
    
   
    
    class func setPredict(authKey:String,cardId:String, cardCategory:String,selectedOption:String, predictType:String, stakePred:String,predictionFor:String,isDetailPrediction:Bool,isReset:Bool,selectedOptionOdd:String, limitBooster:String,returnBooster:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.setPredict
        let parameters = ["authKey":authKey,
                          "cardId":cardId,
                          "cardCategory":cardCategory,
                          "selectedOption":  selectedOption,
                          "predictType":  predictType,
                          "stakePred":  stakePred,
                          "predictionFor":  predictionFor,
                          "isDetailPrediction": isDetailPrediction,
                          "isReset": isReset,
                          "selectedOptionOdd": selectedOptionOdd,
                          "limitBooster": limitBooster,
                          "returnBooster": returnBooster] as [String : Any]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
           
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
                        let guestExpire = json["isGuestExpired"].bool ?? false
                        Helpder.saveGuestExpire(guest: guestExpire)
                        if successKey == false {
                            completion(nil, true)
                            let Alert = Util.alert()
                            
                            Alert.msg(message: message, title: "Warning!")
                            //ANLoader.hide()
                        }else {
                           
                            completion(nil, true)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func resetPredict(authKey:String,cardId:String, cardCategory:String,selectedOption:String, predictType:String, stakePred:String,predictionFor:String,isDetailPrediction:Bool,isReset:Bool, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.setPredict
        let parameters = ["authKey":authKey,
                          "cardId":cardId,
                          "cardCategory":cardCategory,
                          "selectedOption":  selectedOption,
                          "predictType":  predictType,
                          "stakePred":  stakePred,
                          "predictionFor":  predictionFor,
                          "isDetailPrediction": isDetailPrediction,
                          "isReset": isReset
                         ] as [String : Any]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
            
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
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func setFollowing(authKey:String,followId:String, followName:String,followType:String, isReset:Bool, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.setFollow
        let parameters = ["authKey":authKey,
                          "followId":followId,
                          "followName":followName,
                          "followType":  followType,
                          "isReset": isReset
                        ] as [String : Any]
        
        
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
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func getPassBook(authKey:String,PredFilter:[String:Bool],CredFilter:[String:Bool],transDate:String, currentPage:Int, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.getPassbook
        let parameters = ["authKey":authKey,
                          "predsFilter":PredFilter,
                          "credsFilter":CredFilter,
                          "transDate":  transDate,
                          "currentPage": currentPage
            ] as [String : Any]
        
        
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
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func getSupplies(authKey:String, completion: @escaping (_ error:Error?, _ supplyData:SupplyData?, _ limitBoost:LimitBoosterData?, _ returnBoost:LimitBoosterData?)->Void){
        
        let url = Constants.WebService.getSupplyCenter
        let parameters = ["authKey":authKey]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
            
            .responseJSON { response in
                
                switch response.result {
                case .failure(let error):
                    completion(error, nil, nil,nil)
                    print(error)
                    break
                case .success(let value):
                    
                    if response.result.value is NSNull{
                        return
                    }else {
                        
                        
                        var json = JSON(value)
                        
                        
                        let supplyData1 = SupplyData()
                        let limitBooster = LimitBoosterData()
                        let returnBooster = LimitBoosterData()
                        if let tempVar = json["data"].dictionary {
                            
                            supplyData1.predPoints = tempVar["predPoints"]?.int ?? 0
                            supplyData1.credPoints = tempVar["credPoints"]?.int ?? 0
                            supplyData1.limitBoosterValue = tempVar["limitBoosterValue"]?.int ?? 0
                            supplyData1.returnBoosterValue = tempVar["returnBoosterValue"]?.int ?? 0
                            supplyData1.watchVideo = tempVar["watchVideo"]?.string ?? ""
                            supplyData1.totalLimitBooster = tempVar["totalLimitBooster"]?.int ?? 0
                            supplyData1.totalReturnBooster = tempVar["totalReturnBooster"]?.int ?? 0
                           
                            supplyData1.referEarnText = tempVar["referEarnText"]?.string ?? ""
                            supplyData1.referEarnText2 = tempVar["referEarnText2"]?.string ?? ""
                            supplyData1.spinTitle = tempVar["spinTitle"]?.string ?? ""
                            supplyData1.spinText = tempVar["spinText"]?.string ?? ""
                            supplyData1.spinDots = tempVar["spinDots"]?.string ?? ""
                            supplyData1.spinsLeft = tempVar["spinsLeft"]?.string ?? ""
                            supplyData1.spinPredictLeft = tempVar["spinPredictLeft"]?.string ?? ""
                            
                            if let tempVar1 = tempVar["limitBooster"]?.dictionary {
                                limitBooster.twoX = tempVar1["twoX"]?.int ?? 0
                                limitBooster.threeX = tempVar1["threeX"]?.int ?? 0
                                limitBooster.fourX = tempVar1["fourX"]?.int ?? 0
                                limitBooster.fiveX = tempVar1["fiveX"]?.int ?? 0
                                
                                
                            }
                            
                            if let tempVar1 = tempVar["returnBooster"]?.dictionary {
                                returnBooster.twoX = tempVar1["twoX"]?.int ?? 0
                                returnBooster.threeX = tempVar1["threeX"]?.int ?? 0
                                returnBooster.fourX = tempVar1["fourX"]?.int ?? 0
                                returnBooster.fiveX = tempVar1["fiveX"]?.int ?? 0
                                
                            }
                            
                        }
                        completion(nil, supplyData1, limitBooster, returnBooster)
                            
                            
                            
                        
                        
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func redeemVoucher(authKey:String,voucherId:String, packageName:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.redeemVoucher
        let parameters = ["authKey":authKey,
                          "voucherId":voucherId,
                          "packageName":packageName]
        
        
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
                        let voucherCode = json["voucherCode"].string ?? ""
                        Helpder.saveMessage(code: message)
                        Helpder.saveVoucherCode(userId: voucherCode)
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
    
    class func sendMessage(authKey:String,tokenId:String, text:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.sendMessage
        let parameters = ["authKey":authKey,
                          "tokenId":tokenId,
                          "text":text]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
            
            .responseString { response in
                
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
                        completion(nil, true)
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func getReturnBooster(authKey:String,type:String, boosterType:String, totalBoosters:String, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.getBooster
        let parameters = ["authKey":authKey,
                          "type":type,
                          "boosterType":boosterType,
                          "totalBoosters":totalBoosters]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
            
            .responseString { response in
                
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
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func setBid(authKey:String,Id:String, type:String, bidPoints:String, bidSlot:Int, completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.setBid
        let parameters = [ "authKey":authKey,
                           "id":Id,
                           "type":type,
                           "bidPoints":bidPoints,
                           "bidSlot":bidSlot] as [String : Any]
        
        
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
                            completion(nil, false)
                        }else {
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
        }
    }
   
   
    class func saveProfile(authKey:String,email:String, userName:String, fullName:String, dob:String,  shippingAddress:String, otp:String, mobile:String,gender:String, predictionVisibility:Bool, redemptionVisibility:Bool,completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.updateProfile
        let parameters = [ "authKey":authKey,
                           "email":email,
                           "userName":userName,
                           "fullName":fullName,
                           "dob":dob,
                           "shippingAddress":shippingAddress,
                           "otp":otp,
                           "mobile":mobile,
                           "gender":gender,
                           "predictionVisibility":predictionVisibility,
                           "redemptionVisibility":redemptionVisibility,
                           "deviceType":"ios"] as [String : Any]
        
        
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
                    let percentComplete = json["percentComplete"].string ?? ""
                    let showOTP = json["showVerifyOtp"].bool ?? false
                    if let error11 = json["errorList"].dictionary {
                        let error1 = error11["userName"]?.string ?? ""
                        let error2 = error11["email"]?.string ?? ""
                        let error3 = error11["mobile"]?.string ?? ""
                        Helpder.saveUserNameError(userError: error1)
                        Helpder.saveEmailError(emailerror: error2)
                        Helpder.saveMobileError(mobileError: error3)
                    }
                    Helpder.saveMessage(code: message)
                    Helpder.savePercentComplete(mobileError: percentComplete)
                    Helpder.saveProfileOTP(guest: showOTP)
                    if successKey == false {
                        completion(nil, false)
                    }else {
                        UserDefaults.standard.removeObject(forKey: "emailError")
                        UserDefaults.standard.removeObject(forKey: "userNameError")
                        UserDefaults.standard.removeObject(forKey: "mobileError")
                        completion(nil, true)
                    }
                }
        }
    }
    
    class func buyPreds(authKey:String,preds:String,completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.buyPreds
        let parameters = [ "authKey":authKey,
                           "preds":preds]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
            
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
                        let error = json["exists"].array
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
    
    class func CreateToken(authKey:String,id:String,parentQuestion:String,question:String,parentId:String,completion: @escaping (_ error:Error?, _ success:Bool , _ tokenData:TokenData?)->Void){
        
        let url = Constants.WebService.createToken
        let parameters = [ "authKey":authKey,
                           "id":id,
                           "parentQuestion":parentQuestion,
                           "question":question,
                           "parentId":parentId]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
            
            .responseJSON { response in
                
                switch response.result {
                case .failure(let error):
                    completion(error, false, nil)
                    print(error)
                    break
                case .success(let value):
                    
                    if response.result.value is NSNull{
                        return
                    }else {
                        var json = JSON(value)
                        
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        let tokenData = TokenData()
                        Helpder.saveMessage(code: message)
                        
                        if successKey == false {
                            //ANLoader.hide()
                            
                            completion(nil, false, nil)
                        }else {
                            if let tokenList = json["tokensData"].dictionary {
                                tokenData.assignedTo = tokenList["assignedTo"]?.string ?? ""
                                 tokenData.userId = tokenList["userId"]?.string ?? ""
                                 tokenData.title = tokenList["title"]?.string ?? ""
                                 tokenData.eventId = tokenList["eventId"]?.string ?? ""
                                 tokenData.questionId = tokenList["questionId"]?.string ?? ""
                                 tokenData.status = tokenList["status"]?.string ?? ""
                                 tokenData.createdAt = tokenList["createdAt"]?.string ?? ""
                                 tokenData.tokenId = tokenList["tokenId"]?.string ?? ""
                                
                            }
                            completion(nil, true, tokenData)
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func NotifyMe(authKey:String,id:String,type:String,completion: @escaping (_ error:Error?, _ success:Bool)->Void){
        
        let url = Constants.WebService.notifyMe
        let parameters = [ "authKey":authKey,
                           "id":id,
                           "type":type]
        
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
            
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
                            //ANLoader.hide()
                            
                            completion(nil, false)
                        }else {
                            
                            completion(nil, true)
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
        }
    }
    
    class func getSettingNew(completion: @escaping ( _ error:Error?,  _ success:Bool,  _ categoryIcons:[CategoryIcons]?,  _ categoryIcon:[CategoryIcon]?)->Void){
        let url = Constants.WebService.getSettingNew
        let connstatus = Util.Connectivity.isConnectedToInternet()
        let device = Util.getUDIDCode()
        let deviceToken = Helpder.getDeviceToken()
        if(!connstatus)
        {
            let Alert = Util.alert()
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
            completion(nil, false, nil, nil)
        }else {
            let parameters = ["unique_id":device,
                              "deviceToken":"",
                              "deviceType":"ios",
                              "packageName":""] as [String : Any]
            
            
            Alamofire.request(url,method: .post,parameters: parameters,encoding: URLEncoding.default, headers:nil)
                .responseJSON { response in
                    switch response.result {
                    case .failure(let error):
                        completion(error, false, nil, nil)
                        print(error)
                        break
                    case .success(let value):
                        let json = JSON(value)
                        let successKey = json["success"].bool ?? false
                        let message = json["message"].string ?? ""
                        
                        Helpder.saveMessage(code: message)
                        if successKey == false {
                            
                            //ANLoader.hide()
                            completion(nil, false, nil, nil)
                        }else {
                            var categoryList1 = [CategoryIcons]()
                            var categoryList = [CategoryIcon]()
                            if let sections = json["data"].dictionary {
                                let registerFlow = sections["registerFlow"]?.string ?? ""
                                Helpder.saveRegisterFlow(flow: registerFlow)
                                
                            }
                            guard let dataArr = json["data"]["categoryData"].array else {
                                return
                            }
                            
                            guard let dataArr1 = json["data"]["categoryIcons"].array else {
                                return
                            }
                            for data in dataArr {
                                let list = data.dictionary
                                let categoryLst = CategoryIcons()
                                categoryLst.icon = list!["icon"]?.string ?? ""
                                categoryLst.name = list!["name"]?.string ?? ""
                                categoryList1.append(categoryLst)
                            }
                            for data in dataArr1 {
                                let list = data.dictionary
                                let categoryLst = CategoryIcon()
                                categoryLst.icon = list!["icon"]?.string ?? ""
                                categoryLst.name = list!["name"]?.string ?? ""
                                categoryList.append(categoryLst)
                            }
                            
                            completion(nil, true, categoryList1, categoryList)
                        }
                    }
            }
        }
    }
    
    
    class func saveCategory(authKey:String, Category:[String], completion: @escaping ( _ error:Error?,  _ success:Bool)->Void){
        
        let url = Constants.WebService.saveCategory
        let parameters = ["authKey":authKey,
                          "category":Category
            ] as [String : Any]
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers:nil)
            
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
                            
                            completion(nil, true)
                        }
                    }
                }
        }
    }
    
    class func AuthNew(email:String,mobile:String, password:String,type:String, otp:String, unique_id:String,deviceType:String,deviceToken:String, imageURL:String, registerFlow:String,  isGuestRegister:Bool,packageName:String,socialId:String, completion: @escaping ( _ error:Error?,  _ success:Bool)->Void){
        let url = Constants.WebService.AuthNew
        
        let connstatus = Util.Connectivity.isConnectedToInternet()
        if(!connstatus)
        {
            let Alert = Util.alert()
            
            Alert.msg(message: "Please check the internet connectivity", title: "Warning!")
        }else {
            let params = ["email":email,
                          "mobile":mobile,
                          "password":password,
                          "type":type,
                          "otp":otp,
                          "unique_id":unique_id,
                          "deviceType":deviceType,
                          "deviceToken":deviceToken,
                          "imageURL":imageURL,
                          "registerFlow":registerFlow,
                          "isGuestRegister": isGuestRegister,
                          "packageName":packageName,
                          "socialId":socialId] as [String : Any]
            
            
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
                            let useCredsOnly = json["useCredsOnly"].bool ?? true
                            Helpder.saveUserCred(userCred: useCredsOnly)
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
}


