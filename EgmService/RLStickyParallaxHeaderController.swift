//
//  RLStickyParallaxHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit
import SwiftyJSON
import SocketIO

class RLStickyParallaxHeaderController: RLBaseCollectionController {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var txtAccountCredit: UITextField!
    @IBOutlet weak var txtLastLogin: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBAction func transferToEgm(){
        print(#function.description)
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "TransferVC") as! TransferVC
        vc.infoData = self.infoData
        vc.transferType = "EGM"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func transferToAcc(){
        print(#function.description)
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "TransferVC") as! TransferVC
        vc.infoData = self.infoData
        vc.transferType = "ACC"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func login(_ sender: Any){
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.LOGIN_TO_EGM.rawValue,[
                "R" : 1005,
                "EI": "110",
                "MI": "111"
                ])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.LOGOUT_FROM_EGM.rawValue,[
                "R" : 1006,
                "EI": "110",
                "MI": "111"
                ])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    @IBAction func backToSearchRootView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // config the header
        parallaxHeaderReferenceHeight = 426
        parallaxHeaderMinimumReferenceHeight = 110
        parallaxHeaderAlwaysOnTop = true
        disableStickyHeaders = true
        
        // load header
        headerNib = UINib.init(nibName: "RLAlwaysOnTopHeader", bundle: Bundle.main)
        
        // init data
        var data: [String:String] = [:]
        for index in 0..<1 {
            data[String(index)] = ""
        }
        sections = [data]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        /*
        EGMData.shared.AreaEgmId = (self.infoData?["EIF"]["ARE"].stringValue)! + "-" + (self.infoData?["EI"].stringValue)!
        EGMData.shared.EgmCredit = self.infoData?["EIF"]["CC"].intValue
        EGMData.shared.CoinIn = self.infoData?["EIF"]["CI"].intValue
        EGMData.shared.CoinOut = self.infoData?["EIF"]["CO"].intValue
        EGMData.shared.AFTIn = self.infoData?["EIF"]["AI"].intValue
        EGMData.shared.AFTOut = self.infoData?["EIF"]["AO"].intValue
        EGMData.shared.TotalDrop = self.infoData?["EIF"]["TD"].intValue
        EGMData.shared.TotalCacelCredit = self.infoData?["EIF"]["TCC"].intValue
        EGMData.shared.UserName = self.infoData?["MIF"]["N"].stringValue
        EGMData.shared.Level =  self.infoData?["MIF"]["L"].stringValue
        EGMData.shared.AgentName = self.infoData?["MIF"]["AN"].stringValue
        EGMData.shared.UserPhoto = self.infoData?["MIF"]["IMG"].stringValue
        EGMData.shared.CashCredit = self.infoData?["MIF"]["C"].intValue
        EGMData.shared.RestrictCredit = self.infoData?["MIF"]["R"].intValue
        EGMData.shared.NonRestrictCredit = self.infoData?["MIF"]["NR"].intValue
        EGMData.shared.LastLogin = self.infoData?["MIF"]["LLT"].stringValue*/
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? RLSectionHeader
            
            return header!
            
        } else if kind == RLStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
