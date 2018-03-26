//
//  SearchRootVC.Swift
//  EgmService
//
//  Created by David on 12/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SnapKit
import swiftScan
import SwiftyJSON
import SocketIO
//import DGParallaxViewControllerTransition

class SearchRootVC: UIViewController,UITextFieldDelegate,LBXScanViewControllerDelegate{
    //var parallaxTransition:DGParallaxViewControllerTransition?
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var txtEgmId : UITextField!
    @IBOutlet weak var txtPlayerId : UITextField!
    @IBOutlet weak var btnSearchByEgmId : UIButton!
    @IBOutlet weak var btnSearchByPlayerId: UIButton!
    @IBOutlet weak var btnQRScan: UIButton!
    @IBOutlet weak var egmIcon: UIImageView!
    var keyHeight = CGFloat()
    var textFieldTag = 0
    
    @IBAction func searchByEgmId(){
        showEgmView(egmId: txtEgmId.text!)
    }
    
    var infoData: JSON?
    @IBAction func searchByPlayerId(){
        showPlayerView(playerId: txtPlayerId.text!)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SearchByEgmId"){
            let controller = segue.destination as! SearchByEgmIdVC
            print("SearchByEgmId")
            controller.infoData = self.infoData
        }
        else if(segue.identifier == "SearchByPlayerId"){
            let controller = segue.destination as! SearchByPlayerIdVC
            controller.infoData = self.infoData
        }
    }*/
    
    @IBAction func qrScan(){
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = false;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.LineMove;
        
        style.colorAngle = UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        
        
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_Scan_weixin_Line")
        
        
        let vc = MyQRCodeVC();
        vc.scanStyle = style
        vc.scanResultDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func scanFinished(scanResult: LBXScanResult, error: String?){
        //print("scanResult:\(scanResult)")
        let egmId = scanResult.strScanned
        self.dismiss(animated: true, completion: {
                self.showEgmView(egmId: egmId!)
            }
        )
    }
    
    func showEgmView(egmId: String){
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.SEARCH_BY_EGM_ID.rawValue, ["R" : 1002, "EI": egmId])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func showPlayerView(playerId: String){
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.SEARCH_BY_PLAYER_ID.rawValue, ["R" : 1003, "MI": playerId])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEgmId.delegate = self
        txtPlayerId.delegate = self
        // Do any additional setup after loading the view.
        
        /*
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action:#selector(showUserInfo))
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpGesture)*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        egmIcon.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        txtEgmId.layer.borderColor = UIColor.gray.cgColor
        txtEgmId.layer.borderWidth = 1
        txtEgmId.layer.cornerRadius = 20
        
        txtEgmId.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(140)
            make.left.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-60)
            make.height.equalTo(40)
        }
        
        btnSearchByEgmId.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(200)
            make.left.equalTo(UIScreen.main.bounds.width/2-80)
            make.width.equalTo(160)
            make.height.equalTo(70)
        }
        
        btnQRScan.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(260)
            make.right.equalTo(self.view).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        
        let splitView = UIView()
        splitView.backgroundColor =  UIColor.init(red: 29/255, green: 61/255, blue: 80/255, alpha: 1)
        self.view.addSubview(splitView)
        splitView.addSubview(userImage)
        splitView.addSubview(txtPlayerId)
        splitView.addSubview(btnSearchByPlayerId)
        
        splitView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(UIScreen.main.bounds.height/2)
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2)
        }
        
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(350)
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        
        txtPlayerId.layer.borderColor = UIColor.gray.cgColor
        txtPlayerId.layer.borderWidth = 1
        txtPlayerId.layer.cornerRadius = 20
        
        txtPlayerId.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(440)
            make.left.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-60)
            make.height.equalTo(40)
        }
        
        txtEgmId.addTarget(self, action: #selector(textFieldFocus(_:)), for: .editingDidBegin)
        txtPlayerId.addTarget(self, action: #selector(textFieldFocus(_:)), for: .editingDidBegin)
        txtPlayerId.addTarget(self, action: #selector(playerFieldBlur(_:)), for: .editingDidEnd)
        let centerDefault = NotificationCenter.default
        centerDefault.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        btnSearchByPlayerId.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(500)
            make.left.equalTo(UIScreen.main.bounds.width/2-80)
            make.width.equalTo(160)
            make.height.equalTo(70)
        }
        
        SocketIOHelper.shared.socket.removeAllHandlers();
        SocketIOHelper.shared.socket.on(On.SEARCH_BY_EGM_ID_RESULT.rawValue){data, ack in
            print(On.SEARCH_BY_EGM_ID_RESULT.rawValue)
            let json = JSON(data[0])
            if(json["EC"] == 0){
                EGMData.shared.AreaEgmId = (json["EIF"]["ARE"].stringValue) + "-" + (json["EI"].stringValue)
                EGMData.shared.EgmCredit = json["EIF"]["CC"].intValue
                EGMData.shared.CoinIn = json["EIF"]["CI"].intValue
                EGMData.shared.CoinOut = json["EIF"]["CO"].intValue
                EGMData.shared.AFTIn = json["EIF"]["AI"].intValue
                EGMData.shared.AFTOut = json["EIF"]["AO"].intValue
                EGMData.shared.TotalDrop = json["EIF"]["TD"].intValue
                EGMData.shared.TotalCacelCredit = json["EIF"]["TCC"].intValue
                
                //if login then set the login user info
                if (json["MIF"] != JSON.null){
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
                
                //self.navigationController?.performSegue(withIdentifier: "SearchByEgmId", sender: self)
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                //let vc = sb.instantiateViewController(withIdentifier: "SearchByEgmId") as! SearchByEgmIdVC
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                vc.infoData = json
                
                self.navigationController?.pushViewController(vc, animated: true)
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
        
        SocketIOHelper.shared.socket.on(On.SEARCH_BY_PLAYER_ID_RESULT.rawValue){data, ack in
            print(On.SEARCH_BY_PLAYER_ID_RESULT.rawValue)
            let json = JSON(data[0])
            self.infoData = json
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
                
                if (json["EIF"] != JSON.null){
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
                
                //self.navigationController?.performSegue(withIdentifier: "SearchByPlayerId", sender: self)
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                //let vc = sb.instantiateViewController(withIdentifier: "SearchByPlayerId") as! SearchByPlayerIdVC
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                vc.infoData = json
                
                self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    func textFieldFocus(_ textField: UITextField) {
        self.textFieldTag = textField.tag
    }
    
    func playerFieldBlur(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.view.frame
            frame.origin.y = 0
            self.view.frame = frame
            
        }, completion: nil)
        return true
    }
    
    func keyboardWillShow(aNotification: NSNotification) {
        if(self.textFieldTag == 1){
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
    }
    
    func showUserInfo(){
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let viewController : UIViewController = storyboard.instantiateViewController(withIdentifier: "SearchVC")
         /*
         let parallaxTransition = DGParallaxViewControllerTransition()
         parallaxTransition.presentedViewInsets = UIEdgeInsets(top:0, left: 0, bottom: 100, right: 0)
         parallaxTransition.overlayColor = .gray
         parallaxTransition.maximumOverlayAlpha = 0.5
         parallaxTransition.attach(to: viewController)*/
         self.present(viewController, animated: true, completion: nil)
         //self.parallaxTransition = parallaxTransition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtEgmId.resignFirstResponder()
        txtPlayerId.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
