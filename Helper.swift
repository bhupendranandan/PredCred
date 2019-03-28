//
//  Helper.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 25/12/17.
//  Copyright © 2017 Vinay Shankar. All rights reserved.
//

import UIKit

class Helpder:NSObject {
    
    class func saveAuthKey(auth:String){
        let user = UserDefaults.standard

        user.setValue(auth, forKey: "authKey")
        user.synchronize()
    }
    
    class func saveRegisterFlow(flow:String){
        let user = UserDefaults.standard
        
        user.setValue(flow, forKey: "registerFlow")
        user.synchronize()
    }
    class func saveUsername(userName:String){
        let email = UserDefaults.standard
        
        email.setValue(userName, forKey: "userName")
        email.synchronize()
    }
    
    class func saveEmail(userName:String){
        let email = UserDefaults.standard
        
        email.setValue(userName, forKey: "email")
        email.synchronize()
    }
    class func savePwd(password:String){
        let pwd = UserDefaults.standard
        
        pwd.setValue(password, forKey: "password")
        pwd.synchronize()
    }
    
    class func saveGmail(userName:String){
        let email = UserDefaults.standard
        
        email.setValue(userName, forKey: "email1")
        email.synchronize()
    }
    class func saveFmail(userName:String){
        let email = UserDefaults.standard
        
        email.setValue(userName, forKey: "email2")
        email.synchronize()
    }
    class func savePassword(pwd:String){
        let password = UserDefaults.standard
        
        password.setValue(pwd, forKey: "password")
        password.synchronize()
    }
    class func savePred(pred: String){
        let Pred = UserDefaults.standard
        
        Pred.setValue(pred, forKey: "predPoint")
        Pred.synchronize()
    }
    class func savePred1(pred: String){
        let Pred = UserDefaults.standard
        
        Pred.setValue(pred, forKey: "preds")
        Pred.synchronize()
    }
    class func saveName(name:String){
        let username = UserDefaults.standard
        
        username.setValue(name, forKey: "fullName")
        username.synchronize()
    }
    
    class func saveNumber(number:String){
        let mobile = UserDefaults.standard
        
        mobile.setValue(number, forKey: "mobileNumber")
        mobile.synchronize()
    }
    class func saveGender(number:String){
        let mobile = UserDefaults.standard
        
        mobile.setValue(number, forKey: "gender")
        mobile.synchronize()
    }
    
    class func saveAge(number:String){
        let mobile = UserDefaults.standard
        
        mobile.setValue(number, forKey: "age")
        mobile.synchronize()
    }
    class func saveCred(cred:String){
        let Cred = UserDefaults.standard
        
        Cred.setValue(cred, forKey: "credPoint")
        Cred.synchronize()
    }
    
    class func saveReferralCode(referral:String){
        let refer = UserDefaults.standard
        
        refer.setValue(referral, forKey: "referralCode")
        refer.synchronize()
    }
    func saveLoggedState() {
        
        let def = UserDefaults.standard
        def.set(true, forKey: "success") // save true flag to UserDefaults
        def.synchronize()
        
    }
    
    class func saveOTP(OTP:String){
        let otp = UserDefaults.standard
        
        otp.setValue(OTP, forKey: "otp")
        otp.synchronize()
    }
    
    class func saveOTPFor(OTPfor:String){
        let otp = UserDefaults.standard
        
        otp.setValue(OTPfor, forKey: "otpFor")
        otp.synchronize()
    }
    
    class func saveLoginCount(loginCount:Int){
        let count = UserDefaults.standard
        
        count.setValue(loginCount, forKey: "loginCount")
        count.synchronize()
    }
    class func saveCityName(myCity:String){
        let cityName = UserDefaults.standard
        
        cityName.setValue(myCity, forKey: "myCity")
        cityName.synchronize()
    }
    
    class func saveCode(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "code")
        myCode.synchronize()
    }
    class func manOfTheMatch(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "manofthematch")
        myCode.synchronize()
    }
    class func runScore(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "runScore")
        myCode.synchronize()
    }
    class func wicketTaker(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "wicketScore")
        myCode.synchronize()
    }
    class func userID(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "id")
        myCode.synchronize()
    }
    class func userID1(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "id1")
        myCode.synchronize()
    }
    class func userID2(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "id2")
        myCode.synchronize()
    }
    class func socketURL(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "socketURL")
        myCode.synchronize()
    }
    class func footballSocketURL(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "footballSocketURL")
        myCode.synchronize()
    }
    class func timer1(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "timer1")
        myCode.synchronize()
    }
    class func timer2(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "timer2")
        myCode.synchronize()
    }
    class func timer3(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "timer3")
        myCode.synchronize()
    }
    
    class func saveMessage(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "message")
        myCode.synchronize()
    }
    class func saveErrorMessage(code:[String]){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "error")
        myCode.synchronize()
    }
    
    class func saveToken(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "deviceToken")
        myCode.synchronize()
    }
    
    class func saveMobile(code:String){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "mobile")
        myCode.synchronize()
    }
    
    
    class func saveNotification(code:Int){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "isNotification")
        myCode.synchronize()
    }
    class func saveNotificationStatus(code:Int){
        let myCode = UserDefaults.standard
        
        myCode.setValue(code, forKey: "notificationStatus")
        myCode.synchronize()
    }
    class func saveSpinCount(spinCount:Int){
        let mySpinCount = UserDefaults.standard
        
        mySpinCount.setValue(spinCount, forKey: "spinCount")
        mySpinCount.synchronize()
    }
    class func saveStopPosition(stopPos:Int){
        let myStopPos = UserDefaults.standard
        
        myStopPos.setValue(stopPos, forKey: "stopPosition")
        myStopPos.synchronize()
    }
    class func saveIsFirst(isFirst:Bool){
        let myFirstRun = UserDefaults.standard
        
        myFirstRun.setValue(isFirst, forKey: "isFirst")
        myFirstRun.synchronize()
    }
    class func saveUserId(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "userId")
        user.synchronize()
    }
    
    class func saveVoucherCode(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "voucherCode")
        user.synchronize()
    }
    
    class func saveFullNameProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "fullName")
        user.synchronize()
    }
    class func saveUserNameProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "userName")
        user.synchronize()
    }
    class func saveEmailProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "email")
        user.synchronize()
    }
    class func saveMobileNumber(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "mobile")
        user.synchronize()
    }
    class func saveDOBProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "dob")
        user.synchronize()
    }
    class func saveGenderProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "gender")
        user.synchronize()
    }
    class func saveAddressProfile(userId:String){
        let user = UserDefaults.standard
        
        user.setValue(userId, forKey: "address")
        user.synchronize()
    }
    class func saveRedeemptionProfile(isFirst:Bool){
        let myFirstRun = UserDefaults.standard
        
        myFirstRun.setValue(isFirst, forKey: "redeemptionTrack")
        myFirstRun.synchronize()
    }
    class func savePredictionProfile(isFirst:Bool){
        let myFirstRun = UserDefaults.standard
        
        myFirstRun.setValue(isFirst, forKey: "predictionTrack")
        myFirstRun.synchronize()
    }
    class func savePeopleType(peopleType:String){
        let myFirstRun = UserDefaults.standard
        
        myFirstRun.setValue(peopleType, forKey: "peopleType")
        myFirstRun.synchronize()
    }
    class func saveSelectedIndex(peopleType:Int){
        let myFirstRun = UserDefaults.standard
        
        myFirstRun.setValue(peopleType, forKey: "selectedIndex")
        myFirstRun.synchronize()
    }
    class func saveGuestExpire(guest:Bool){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(guest, forKey: "isGuestExpired")
        guestUser.synchronize()
    }
    class func saveUserNameError(userError:String){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(userError, forKey: "userNameError")
        guestUser.synchronize()
    }
    class func saveEmailError(emailerror:String){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(emailerror, forKey: "emailError")
        guestUser.synchronize()
    }
    class func saveMobileError(mobileError:String){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(mobileError, forKey: "mobileError")
        guestUser.synchronize()
    }
    class func saveProfileOTP(guest:Bool){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(guest, forKey: "showVerifyOtp")
        guestUser.synchronize()
    }
    class func savePercentComplete(mobileError:String){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(mobileError, forKey: "percentComplete")
        guestUser.synchronize()
    }
    class func saveUserLevel(userLevel:Int){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(userLevel, forKey: "level")
        guestUser.synchronize()
    }
    
    class func saveGuestUser(user:Bool){
        let guestUser = UserDefaults.standard
        
        guestUser.setValue(user, forKey: "isGuestUser")
        guestUser.synchronize()
    }
    
    class func saveDeviceToken(deviceToken:String){
        let deviceToken1 = UserDefaults.standard
        
        deviceToken1.setValue(deviceToken, forKey: "deviceToken1")
        deviceToken1.synchronize()
    }
    
    class func saveUserCred(userCred:Bool){
        let deviceToken1 = UserDefaults.standard
        
        deviceToken1.setValue(userCred, forKey: "useCredsOnly")
        deviceToken1.synchronize()
    }
    
    
    // Get defaults
    class func getUserCred() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "useCredsOnly") as? Bool
    }
    
    class func getDeviceToken() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "deviceToken1") as? String
    }
    class func getGuestRegister() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isGuestUser") as? Bool
    }
    class func getUserLevel() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "level") as? Int
    }
    class func getProfileOTP() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "showVerifyOtp") as? Bool
    }
    class func getPercentCompelte() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "percentComplete") as? String
    }
    class func getEmailError() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "emailError") as? String
    }
    class func getUsernameError() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "userNameError") as? String
    }
    class func getMobileError() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "mobileError") as? String
    }
    class func getGuestUser() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isGuestExpired") as? Bool
    }
    class func getSelectedIndex() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "selectedIndex") as? Int
    }
    class func getpeopleType() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "peopleType") as? String
    }
    class func getRedeemptionProfile() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "redeemptionTrack") as? Bool
    }
    class func getpredictionProfile() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "predictionTrack") as? Bool
    }
    class func getFullNameProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "fullName") as? String
    }
    class func getUserNameProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "userName") as? String
    }
    class func getEmailProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    class func getMobileProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "mobile") as? String
    }
    class func getDOBProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "dob") as? String
    }
    class func getGenderProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "gender") as? String
    }
    class func getShippingProfile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "address") as? String
    }
    class func getVoucherCode() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "voucherCode") as? String
    }
    
    class func getProfileUserId() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "userId") as? String
    }
    class func getFirstFlow() -> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "isFirst") as? Bool
    }
    class func getRegisterFlow() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "registerFlow") as? String
    }
    class func getStopPosition() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "stopPosition") as? Int
    }
    class func getSpinCount() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "spinCount") as? Int
    }
    class func getNotificationStatus() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "notificationStatus") as? Int
    }
    class func getNotification() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "isNotification") as? Int
    }
    class func getToken() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "deviceToken") as? String
    }
    class func getMessage() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "message") as? String
    }
    class func getErrorMessage() -> [String]?{
        let def = UserDefaults.standard
        return def.object(forKey: "error") as? [String]
    }
    class func getSocketURL() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "socketURL") as? String
    }
    class func getFootballSocketURL() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "footballSocketURL") as? String
    }
    class func getTimer1() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "timer1") as? String
    }
    class func getTimer2() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "timer2") as? String
    }
    class func getTimer3() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "timer3") as? String
    }
    class func getUserId() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "id") as? String
    }
    class func getUserId1() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "id1") as? String
    }
    class func getUserId2() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "id2") as? String
    }
    
    class func getManOftheMatch() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "manofthematch") as? String
    }
    class func getRunScore() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "runScore") as? String
    }
    class func getWicketTaker() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "wicketScore") as? String
    }
    class func getCode() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "code") as? String
    }
    class func getCityName() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "myCity") as? String
    }
    
    class func getAuthKey() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "authKey") as? String
    }
    
    class func getUserName() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "userName") as? String
    }
    
    class func getEmail() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    class func getGmail() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email1") as? String
    }
    class func getFmail() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email2") as? String
    }
    class func getPassword() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "password") as? String
    }
    
    class func getOTP() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "otp") as? String
    }
    class func getOTPFor() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "otpFor") as? String
    }
    
    
    class func getLoginCount() -> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "loginCount") as? Int
    }
    
    class func getCred() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "credPoint") as? String
    }
    class func getPred() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "predPoint") as? String
    }
    class func getPred1() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "preds") as? String
    }
    class func getName() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "fullName") as? String
    }
    class func getMobile() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "mobileNumber") as? String
    }
    class func getUserMob() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "mobile") as? String
    }
    
    class func getReferralCode() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "referralCode") as? String
    }
    
    class func getGender() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "gender") as? String
    }
    class func getAge() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "age") as? String
    }
    
}
