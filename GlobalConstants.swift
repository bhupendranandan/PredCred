//
//  GlobalConstants.swift
//  PredCred
//
//  Created by PREDCRED-VIDEOCON GAMES on 12/12/17.
//  Copyright © 2017 Vinay Shankar. All rights reserved.
//

import Foundation


let mainpath = "https://api.predcred.com/v4/"
let subPath = "https://api.predcred.com/v5/"
let baseURL =  "https://predcred.com/v7/"
let productionURL = "https://api.predcred.com/v7/"
struct Constants {
    
//    struct DB {
//        static let name = "stmary_school_app.sqlite"
//        static let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//    }
    struct WebService {
        
        static let login = "\(baseURL)authLogin"
        static let register = "\(baseURL)authRegister"
        static let OTP = "\(baseURL)getOtp"
        static let AuthNew = "\(baseURL)authNew"
        static let guestLogin = "\(baseURL)guestLogin"
        static let getTournamentProfiles = "\(baseURL)getProfiles"
        static let getFollowList = "\(baseURL)getFollowList"
        static let profile = "\(baseURL)getProfile"
        static let predictCentre = "\(baseURL)getPredictCenter"
        static let leaderBoard = "\(baseURL)getLeaderboard"
        static let getPlayers = "\(baseURL)getPlayers"
        static let achievement = "\(baseURL)achievements"
        static let predictionTrack = "\(baseURL)predictionTrack"
        static let redeemptionTrack = "\(baseURL)redeemptionTrack"
        static let getPassbook = "\(baseURL)getPassbook"
        static let setPredict = "\(baseURL)setPredict"
        static let setFollow = "\(baseURL)setFollow"
        static let redeemptionList = "\(baseURL)redeemptionList"
        static let getMyBids = "\(baseURL)getMyBids"
        static let getHelpCenter = "\(baseURL)getHelpCenter"
        static let getChats = "\(baseURL)getChats"
        static let ChangePassword = "\(baseURL)changePassword"
        static let setPassword = "\(baseURL)setPassword"
        static let getUserInfo  = "\(baseURL)getUserInfo"
        static let redeemVoucher = "\(baseURL)redeemVoucher"
        static let getSetting = "\(baseURL)getSettings"
        static let validateUser = "\(baseURL)validateUser"
        static let getSupplyCenter = "\(baseURL)getSupplyCenter"
        static let submitReferral = "\(baseURL)submitReferral"
        static let updateLogo = "\(baseURL)updateLogo"
        static let updateProductLogo = "\(baseURL)uploadProductPhoto"
        static let getSettingNew = "\(baseURL)getSettingsNew"
        static let saveCategory = "\(baseURL)saveCategory"
        static let earningData = "\(baseURL)referEarn"
        static let getHelpCentre = "\(baseURL)getHelpCenter"
        static let sendMessage = "\(baseURL)sendMessage"
        static let getBooster = "\(baseURL)getBooster"
        static let notification = "\(baseURL)getNotification"
        static let getFollow  = "\(baseURL)getFollowData"
        static let myBid  = "\(baseURL)getMyBids"
        static let setBid  = "\(baseURL)setBid"
        static let updateProfile  = "\(baseURL)updateProfile"
        static let buyPreds  = "\(baseURL)buyPreds"
        static let createToken  = "\(baseURL)createToken"
        static let notifyMe  = "\(baseURL)notifyMe"
        
    }
    
    struct Login {
        static let loginbtn : UInt = 0x0a29d8
        static let registerbtn : UInt = 0x5aabd6
        static let lightloginbtn : UInt = 0xd29b3e
        static let demologin = "4321098765"
        static let demodeviceUDID = "videocon123"
    }
    
    struct UserDefaults {
        static let  UUID = "videocon123"
       
    }
}
