//
//  PasswordVC.swift
//  EgmService
//
//  Created by David on 18/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class PasswordVC: UIViewController {

    var transferType:String!
    var infoData:JSON?
    var delegate:ModalVCDelegate?
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnDot1: UIButton!
    @IBOutlet weak var btnDot2: UIButton!
    @IBOutlet weak var btnDot3: UIButton!
    @IBOutlet weak var btnDot4: UIButton!
    @IBOutlet weak var btnNumber0: UIButton!
    @IBOutlet weak var btnNumber1: UIButton!
    @IBOutlet weak var btnNumber2: UIButton!
    @IBOutlet weak var btnNumber3: UIButton!
    @IBOutlet weak var btnNumber4: UIButton!
    @IBOutlet weak var btnNumber5: UIButton!
    @IBOutlet weak var btnNumber6: UIButton!
    @IBOutlet weak var btnNumber7: UIButton!
    @IBOutlet weak var btnNumber8: UIButton!
    @IBOutlet weak var btnNumber9: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    var Password:String = "" {
        didSet{
            switch Password.characters.count {
                case 1:
                    btnDot1.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot2.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                    btnDot3.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                    btnDot4.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                case 2:
                    btnDot1.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot2.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot3.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                    btnDot4.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                case 3:
                    btnDot1.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot2.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot3.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot4.setBackgroundImage(UIImage.init(named: "smallDot_empty"), for: UIControlState.normal)
                case 4:
                    btnDot1.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot2.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot3.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                    btnDot4.setBackgroundImage(UIImage.init(named: "smallDot"), for: UIControlState.normal)
                
                default:
                    break
            }
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if(self.Password.characters.count<4){
            let alertController = UIAlertController(title: "Message", message: "Password invalidate", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            return;
        }
        
        if(self.transferType == "EGM"){
            if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
                SocketIOHelper.shared.socket.emit(Emit.TRANSFER_TO_EGM.rawValue,[
                    "R" : 1007,
                    "EI": "100",
                    "MI": "10011",
                    "P" : "gonzo1982",
                    "A" : 1000
                    ])
            }
            else{
                let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
            }
        }
        else if(self.transferType == "ACC"){
            if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
                SocketIOHelper.shared.socket.emit(Emit.TRANSFER_TO_ACC.rawValue,[
                    "R" : 1008,
                    "EI": "100",
                    "MI": "10011",
                    "P" : "gonzo1982",
                    "A" : 1000
                    ])
            }
            else{
                let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(self.transferType)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SocketIOHelper.shared.socket.removeAllHandlers();
        SocketIOHelper.shared.socket.on(On.TRANSFER_TO_EGM_RESULT.rawValue){data, ack in
            let json = JSON(data[0])
            //print(json)
            if(json["EC"] == 0){
                EGMData.shared.AccountCredit = json["ACC"].intValue
                EGMData.shared.EgmCredit = json["ECC"].intValue
                //self.delegate!.updateData(ecc: json["ECC"].stringValue, acc: json["ACC"].stringValue)
                //let vc = (self.navigationController?.viewControllers[2]) as! RLStickyParallaxHeaderController
                //vc.updateData(ecc: json["ECC"].stringValue, acc: json["ACC"].stringValue)
                //self.navigationController?.popToViewController(vc, animated: true)
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                self.navigationController?.viewControllers[2] = vc;
                let vcUpdate = (self.navigationController?.viewControllers[2]) as! RLStickyParallaxHeaderController
                self.navigationController?.popToViewController(vcUpdate, animated: true)
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
        
        SocketIOHelper.shared.socket.on(On.TRANSFER_TO_ACC_RESULT.rawValue){data, ack in
            let json = JSON(data[0])
            print(json)
            if(json["EC"] == 0){
                EGMData.shared.AccountCredit = json["ACC"].intValue
                EGMData.shared.EgmCredit = json["ECC"].intValue
                //self.delegate!.updateData(ecc: json["ECC"].stringValue, acc: json["ACC"].stringValue)
                //let vc = (self.navigationController?.viewControllers[2]) as! RLStickyParallaxHeaderController
                //vc.updateData(ecc: json["ECC"].stringValue, acc: json["ACC"].stringValue)
                //self.navigationController?.popToViewController(vc, animated: true)
                let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = sb.instantiateViewController(withIdentifier: "RLStickyParallaxHeader") as! RLStickyParallaxHeaderController
                self.navigationController?.viewControllers[2] = vc;
                let vcUpdate = (self.navigationController?.viewControllers[2]) as! RLStickyParallaxHeaderController
                self.navigationController?.popToViewController(vcUpdate, animated: true)
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
        
        lblMessage.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        btnDot1.snp.makeConstraints { (make) in
            make.top.equalTo(85)
            make.centerX.equalToSuperview().offset(-50)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        btnDot2.snp.makeConstraints { (make) in
            make.top.equalTo(85)
            make.centerX.equalToSuperview().offset(-15)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        btnDot3.snp.makeConstraints { (make) in
            make.top.equalTo(85)
            make.centerX.equalToSuperview().offset(20)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        btnDot4.snp.makeConstraints { (make) in
            make.top.equalTo(85)
            make.centerX.equalToSuperview().offset(55)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        btnNumber1.snp.makeConstraints { (make) in
            make.top.equalTo(140)
            make.centerX.equalToSuperview().offset(-110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber2.snp.makeConstraints { (make) in
            make.top.equalTo(140)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber3.snp.makeConstraints { (make) in
            make.top.equalTo(140)
            make.centerX.equalToSuperview().offset(110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber4.snp.makeConstraints { (make) in
            make.top.equalTo(240)
            make.centerX.equalToSuperview().offset(-110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber5.snp.makeConstraints { (make) in
            make.top.equalTo(240)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber6.snp.makeConstraints { (make) in
            make.top.equalTo(240)
            make.centerX.equalToSuperview().offset(110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber7.snp.makeConstraints { (make) in
            make.top.equalTo(340)
            make.centerX.equalToSuperview().offset(-110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber8.snp.makeConstraints { (make) in
            make.top.equalTo(340)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber9.snp.makeConstraints { (make) in
            make.top.equalTo(340)
            make.centerX.equalToSuperview().offset(110)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnNumber0.snp.makeConstraints { (make) in
            make.top.equalTo(440)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        btnConfirm.snp.makeConstraints { (make) in
            make.bottom.equalTo(-30)
            make.centerX.equalToSuperview().offset(-80)
            make.width.equalTo(160)
            make.height.equalTo(70)
        }
        
        btnCancel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-30)
            make.centerX.equalToSuperview().offset(80)
            make.width.equalTo(160)
            make.height.equalTo(70)
        }
        
        btnNumber0.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber1.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber2.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber3.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber4.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber5.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber6.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber7.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber8.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
        btnNumber9.addTarget(self, action: #selector(indicatePassword(sender:)), for: UIControlEvents.touchUpInside)
    }

    func indicatePassword(sender:UIButton) {
        if(self.Password.characters.count<4){
            self.Password = self.Password.appending(String(sender.tag))
        }
        else{
            self.Password = String(sender.tag)
        }
        print(self.Password)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     @IBOutlet weak var btnConfirm: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
