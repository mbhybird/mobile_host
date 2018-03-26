//
//  RLBaseCollectionController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit
import SwiftyJSON
import SocketIO
/**
 *  Base class for common config
 */
class RLBaseCollectionController: UICollectionViewController,UITextFieldDelegate {
    var infoData: JSON?
    var sections: [[String:String]]!
    var headerNib: UINib!
    var disableStickyHeaders: Bool! = false
    var parallaxHeaderAlwaysOnTop: Bool! = false
    var parallaxHeaderReferenceHeight: CGFloat! = 0.0
    var parallaxHeaderMinimumReferenceHeight: CGFloat! = 0.0
    var playerId: String! = ""
    var keyHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadLayout()
        collectionView?.register(headerNib, forSupplementaryViewOfKind: RLStickyHeaderParallaxHeader, withReuseIdentifier: "header")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SocketIOHelper.shared.socket.removeAllHandlers();
        SocketIOHelper.shared.socket.on(On.GET_PLAYER_INFO_RESULT.rawValue){data, ack in
            print(On.GET_PLAYER_INFO_RESULT.rawValue)
            let json = JSON(data[0])
            print(json)
            if(json["EC"] == 0){
                //update the current user info
                EGMData.shared.UserName = json["MIF"]["N"].stringValue
                EGMData.shared.Level =  "Level " + json["MIF"]["L"].stringValue
                EGMData.shared.AgentName = json["MIF"]["AN"].stringValue
                EGMData.shared.UserPhoto = json["MIF"]["IMG"].stringValue
                EGMData.shared.CashCredit = json["MIF"]["C"].intValue
                EGMData.shared.RestrictCredit = json["MIF"]["R"].intValue
                EGMData.shared.NonRestrictCredit = json["MIF"]["NR"].intValue
                EGMData.shared.LastLogin = json["MIF"]["LLT"].stringValue
                EGMData.shared.AccountCredit = json["MIF"]["AC"].intValue
                
                if(json["EIF"] != JSON.null){
                    EGMData.shared.AreaEgmId = (json["EIF"]["ARE"].stringValue) + "-" + (json["EI"].stringValue)
                    EGMData.shared.EgmCredit = json["EIF"]["CC"].intValue
                    EGMData.shared.CoinIn = json["EIF"]["CI"].intValue
                    EGMData.shared.CoinOut = json["EIF"]["CO"].intValue
                    EGMData.shared.AFTIn = json["EIF"]["AI"].intValue
                    EGMData.shared.AFTOut = json["EIF"]["AO"].intValue
                    EGMData.shared.TotalDrop = json["EIF"]["TD"].intValue
                    EGMData.shared.TotalCacelCredit = json["EIF"]["TCC"].intValue
                    
                    EGMData.shared.IsLogin = true
                }
                else{
                    EGMData.shared.IsLogin = false
                }
                
                //update field data
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                vc.infoData = self.infoData
                self.navigationController?.viewControllers[2] = vc;
                
            }
            else{
                let alertController = UIAlertController(title: "Warning", message: json["D"].string, preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:{ _ in
                    
                })
            }
        }
        
        SocketIOHelper.shared.socket.on(On.GET_EGM_INFO_RESULT.rawValue){data, ack in
            print(On.GET_EGM_INFO_RESULT.rawValue)
            let json = JSON(data[0])
            print(json)
            if(json["EC"] == 0){
                //update the current egm info
                EGMData.shared.AreaEgmId = (json["EIF"]["ARE"].stringValue) + "-" + (json["EI"].stringValue)
                EGMData.shared.EgmCredit = json["EIF"]["CC"].intValue
                EGMData.shared.CoinIn = json["EIF"]["CI"].intValue
                EGMData.shared.CoinOut = json["EIF"]["CO"].intValue
                EGMData.shared.AFTIn = json["EIF"]["AI"].intValue
                EGMData.shared.AFTOut = json["EIF"]["AO"].intValue
                EGMData.shared.TotalDrop = json["EIF"]["TD"].intValue
                EGMData.shared.TotalCacelCredit = json["EIF"]["TCC"].intValue
                
                if(json["MIF"] != JSON.null){
                    EGMData.shared.UserName = json["MIF"]["N"].stringValue
                    EGMData.shared.Level =  "Level " + json["MIF"]["L"].stringValue
                    EGMData.shared.AgentName = json["MIF"]["AN"].stringValue
                    EGMData.shared.UserPhoto = json["MIF"]["IMG"].stringValue
                    EGMData.shared.CashCredit = json["MIF"]["C"].intValue
                    EGMData.shared.RestrictCredit = json["MIF"]["R"].intValue
                    EGMData.shared.NonRestrictCredit = json["MIF"]["NR"].intValue
                    EGMData.shared.LastLogin = json["MIF"]["LLT"].stringValue
                    EGMData.shared.AccountCredit = json["MIF"]["AC"].intValue
                    
                    EGMData.shared.IsLogin = true
                }
                else{
                    EGMData.shared.IsLogin = false
                }
                
                //update field data
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                vc.infoData = self.infoData
                self.navigationController?.viewControllers[2] = vc;
            }
            else{
                let alertController = UIAlertController(title: "Warning", message: json["D"].string, preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:{ _ in
                    
                })
            }
        }
        
        SocketIOHelper.shared.socket.on(On.LOGIN_TO_EGM_RESULT.rawValue){data, ack in
            print(On.LOGIN_TO_EGM_RESULT.rawValue)
            let json = JSON(data[0])
            if(json["EC"] == 0){
                EGMData.shared.IsLogin = true
                self.collectionView?.reloadData()
            }
            else{
                let alertController = UIAlertController(title: "Warning", message: json["D"].string, preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:{ _ in
                })
            }
        }
        
        SocketIOHelper.shared.socket.on(On.LOGOUT_FROM_EGM_RESULT.rawValue){data, ack in
            print(On.LOGOUT_FROM_EGM_RESULT.rawValue)
            let json = JSON(data[0])
            if(json["EC"] == 0){
                EGMData.shared.IsLogin = false
                self.collectionView?.reloadData()
            }
            else{
                let alertController = UIAlertController(title: "Warning", message: json["D"].string, preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:{ _ in
                })
            }
        }
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        reloadLayout()
    }
    
    func reloadLayout() {
        let layout = collectionViewLayout as? RLStickyHeaderFlowLayout
        
        if (layout != nil) {
            layout!.itemSize = CGSize(width: view.frame.size.width, height: layout!.itemSize.height)
            
            layout!.parallaxHeaderReferenceSize = CGSize(width: view.frame.size.width, height: parallaxHeaderReferenceHeight)
            
            layout!.parallaxHeaderMinimumReferenceSize = CGSize(width: view.frame.size.width, height: parallaxHeaderMinimumReferenceHeight)
            layout!.parallaxHeaderAlwaysOnTop = parallaxHeaderAlwaysOnTop
            
            // If we want to disable the sticky header effect
            layout!.disableStickyHeaders = disableStickyHeaders
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RLCollectionCell
        
        let obj = sections[indexPath.section]
        let values = Array(obj.values)
        
        if sections.count == 1 {
            //cell!.textLabel!.text = "\(values[indexPath.item])\(indexPath.item)"
            cell!.lblUserName.snp.makeConstraints({ (make) in
                make.left.equalTo(cell!.userPhoto).offset(140)
                make.top.equalTo(50)
            })
            
            cell!.lblLevel.snp.makeConstraints({ (make) in
                make.left.equalTo(cell!.userPhoto).offset(140)
                make.top.equalTo(80)
            })
            
            cell!.lblAgentName.snp.makeConstraints({ (make) in
                make.left.equalTo(cell!.userPhoto).offset(140)
                make.top.equalTo(110)
            })
            
            cell!.bgView.snp.makeConstraints({ (make) in
                make.top.equalTo(180)
                make.width.equalToSuperview()
                make.height.equalTo(200)
            })
            
            cell!.lblCashCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(20)
                make.left.equalTo(20)
            })
            
            cell!.txtCashCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(20+2)
                make.left.equalTo(130)
            })
            
            cell!.lblRestrictedCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(50)
                make.left.equalTo(20)
            })
            
            cell!.txtRestrictedCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(50+2)
                make.left.equalTo(170)
            })
            
            cell!.lblNonRestrictedCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(80)
                make.left.equalTo(20)
            })
            
            cell!.txtNonRestrictedCredit.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(80+2)
                make.left.equalTo(210)
            })
            
            cell!.lblLastLogin.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(150)
                make.left.equalTo(20)
            })
            
            cell!.txtLastLogin.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(150+2)
                make.left.equalTo(120)
            })
            
            cell!.lblUserName.text = EGMData.shared.UserName
            cell!.lblLevel.text = EGMData.shared.Level
            cell!.lblAgentName.text = EGMData.shared.AgentName
            cell!.txtCashCredit.text = String(EGMData.shared.CashCredit)
            cell!.txtLastLogin.text = EGMData.shared.LastLogin
            cell!.txtNonRestrictedCredit.text = String(EGMData.shared.NonRestrictCredit)
            cell!.txtRestrictedCredit.text = String(EGMData.shared.RestrictCredit)
            
            let imgUrl = EGMData.shared.UserPhoto
            if(EGMData.shared.UserName != ""){
                let url = URL(string: imgUrl!)
                let data = try! Data(contentsOf: url!)
                cell!.userPhoto.image = UIImage(data:data)
                
                cell!.userPhoto.snp.makeConstraints({ (make) in
                    make.left.equalTo(60)
                    make.top.equalTo(50)
                    make.width.equalTo(80)
                    make.height.equalTo(80)
                })
                
                cell!.btnSearchPlayer.isHidden = true
                cell!.txtSearchPlayer.isHidden = true
            }
            else{
                cell!.userPhoto.image = UIImage(named: "emptyMember")
                
                cell!.userPhoto.snp.makeConstraints({ (make) in
                    make.left.equalTo(20)
                    make.top.equalTo(50)
                    make.width.equalTo(60)
                    make.height.equalTo(60)
                })
                
                cell!.btnSearchPlayer.isHidden = false
                cell!.txtSearchPlayer.isHidden = false
                cell!.txtSearchPlayer.delegate = self
                
                cell!.txtSearchPlayer.layer.cornerRadius = 20
                cell!.txtSearchPlayer.snp.makeConstraints({ (make) in
                    make.left.equalTo(cell!.userPhoto).offset(70)
                    make.top.equalTo(55)
                    make.width.equalTo(180)
                    make.height.equalTo(50)
                })
                cell!.btnSearchPlayer.snp.makeConstraints({ (make) in
                    make.left.equalTo(cell!.txtSearchPlayer).offset(200)
                    make.top.equalTo(55)
                    make.width.equalTo(50)
                    make.height.equalTo(50)
                })
        
                cell!.txtSearchPlayer.addTarget(self, action: #selector(playerIdChanged), for: .editingChanged)
                //cell!.txtSearchPlayer.addTarget(self, action: #selector(playerFocus), for: .editingDidBegin)
                cell!.btnSearchPlayer.addTarget(self, action: #selector(searchByPlayerId), for: .touchUpInside)
                cell!.txtSearchPlayer.addTarget(self, action: #selector(playerBlur), for: .editingDidEnd)
                let centerDefault = NotificationCenter.default
                centerDefault.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
            }
            
            cell!.btnLogin.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(250)
                make.left.equalTo(UIScreen.main.bounds.width/2-150)
                make.width.equalTo(150)
                make.height.equalTo(60)
            })
            
            cell!.btnLogout.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(250)
                make.right.equalTo(-UIScreen.main.bounds.width/2+150)
                make.width.equalTo(150)
                make.height.equalTo(60)
            })
            
            cell!.btnTransferToEgm.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(250+60)
                make.left.equalTo(UIScreen.main.bounds.width/2-150)
                make.width.equalTo(150)
                make.height.equalTo(60)
            })
            
            cell!.btnTransferToAcc.snp.makeConstraints({ (make) in
                make.top.equalTo(cell!.bgView).offset(250+60)
                make.right.equalTo(-UIScreen.main.bounds.width/2+150)
                make.width.equalTo(150)
                make.height.equalTo(60)
            })
            
            cell!.btnLogin.isEnabled = !EGMData.shared.IsLogin && EGMData.shared.AreaEgmId != ""
            cell!.btnLogout.isEnabled = EGMData.shared.IsLogin
            cell!.btnTransferToEgm.isEnabled = EGMData.shared.IsLogin && EGMData.shared.AccountCredit > 0
            cell!.btnTransferToAcc.isEnabled = EGMData.shared.IsLogin && EGMData.shared.EgmCredit > 0 
            
        }else {
            //cell!.textLabel!.text = values[indexPath.item]
        }
        
        
        return cell!
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    /*
    func playerFocus(sender:UITextField){
        print("onFocus")
    }*/
    
    func playerBlur() -> Bool {
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.view.frame
            frame.origin.y = 0
            self.view.frame = frame
            
        }, completion: nil)
        return true
    }
    
    func keyboardWillShow(aNotification: NSNotification) {
        let userinfo: NSDictionary = aNotification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIKeyboardFrameEndUserInfoKey)
        let keyboardRec = (nsValue as AnyObject).cgRectValue
        let height = keyboardRec?.size.height
        self.keyHeight = height!
        
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.view.frame
            frame.origin.y = -self.keyHeight
            self.view.frame = frame
        }, completion: nil)
    }
    
    func playerIdChanged(sender:UITextField){
        self.playerId = sender.text ?? ""
    }
    
    func searchByPlayerId(){
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.GET_PLAYER_INFO.rawValue, ["R" : 1009, "MI": self.playerId ])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? RLSectionHeader
            
            let obj = sections[indexPath.section]
            let values = Array(obj.keys)
            
            header!.textLabel!.text = values[indexPath.item]
            
            return header!
            
        } else if kind == RLStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("hit cell at \(indexPath).....")
        //let view = headerNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        //let areaEgmId = (view.viewWithTag(1) as! UILabel).text
        //print(areaEgmId)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
