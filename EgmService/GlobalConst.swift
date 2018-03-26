//
//  GlobalConst.swift
//  EgmService
//
//  Created by David on 12/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import Foundation
import UIKit
import SocketIO

protocol ModalVCDelegate{
    func updateData(ecc:String,acc:String)
}

final class SocketIOHelper: NSObject {
    static let shared = SocketIOHelper()
    var socket:SocketIOClient!
    private override init() {
        socket = SocketIOClient(socketURL: URL(string: "http://arts.things.buzz:3000")!, config: [.log(false), .forcePolling(false)])
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        //socket.onAny{print("got event: \($0.event) with items \($0.items)")}
        socket.connect()
    }

}

final class EGMData: NSObject{
    static let shared = EGMData()
    var EgmCredit:Int! = 0
    var AreaEgmId:String! = ""
    var CoinIn:Int! = 0
    var CoinOut:Int! = 0
    var AFTIn:Int! = 0
    var AFTOut:Int! = 0
    var TotalDrop:Int! = 0
    var TotalCacelCredit:Int! = 0
    var UserPhoto:String! = ""
    var UserName:String! = ""
    var Level:String! = ""
    var AgentName:String! = ""
    var CashCredit:Int! = 0
    var RestrictCredit:Int! = 0
    var NonRestrictCredit:Int! = 0
    var LastLogin:String! = ""
    var AccountCredit:Int! = 0
    var IsLogin:Bool =  false
}

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

enum Emit: String {
    case MOTIX_LOGIN = "motixLogin"
    case SEARCH_BY_EGM_ID  = "searchByEgmId"
    case SEARCH_BY_PLAYER_ID  = "searchByPlayerId"
    case LOGIN_TO_EGM = "loginToEgm"
    case LOGOUT_FROM_EGM = "logoutFromEgm"
    case TRANSFER_TO_EGM = "transferToEgm"
    case TRANSFER_TO_ACC = "transferToAcc"
    case GET_PLAYER_INFO = "getPlayerInfo"
    case GET_EGM_INFO    = "getEgmInfo"
}

enum On: String {
    case MOTIX_LOGIN_RESULT = "motixLoginResult"
    case SEARCH_BY_EGM_ID_RESULT  = "searchByEgmIdResult"
    case SEARCH_BY_PLAYER_ID_RESULT  = "searchByPlayerIdResult"
    case LOGIN_TO_EGM_RESULT = "loginToEgmResult"
    case LOGOUT_FROM_EGM_RESULT = "logoutFromEgmResult"
    case TRANSFER_TO_EGM_RESULT = "transferToEgmResult"
    case TRANSFER_TO_ACC_RESULT = "transferToAccResult"
    case GET_PLAYER_INFO_RESULT = "getPlayerInfoResult"
    case GET_EGM_INFO_RESULT    = "getEgmInfoResult"
}
