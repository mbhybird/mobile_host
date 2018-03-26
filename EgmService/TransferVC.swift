//
//  TransferVC.swift
//  EgmService
//
//  Created by David on 18/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SwiftyJSON

class TransferVC: UIViewController,ModalVCDelegate {
    
    var infoData:JSON?
    var transferType:String?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblAreaEgmId: UILabel!
    @IBOutlet weak var lblEgmCredit: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var txtAccountCredit: UITextField!
    @IBOutlet weak var txtTransfer: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var iconEGM: UIImageView!
    @IBOutlet weak var lblAccountCredit: UILabel!
    @IBOutlet weak var creditBGView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBAction func minus(){
        let currentValue = Int(txtTransfer.text!)!
        if(currentValue > 1000){
            txtTransfer.text = String(currentValue - 1000)
        }
    }
    
    @IBAction func plus(){
        txtTransfer.text = String(Int(txtTransfer.text!)! + 1000)
    }
    
    @IBAction func backToPlayerView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirm(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "PasswordVC") as! PasswordVC
        vc.transferType = self.transferType
        vc.infoData = self.infoData
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //实现协议中的方法
    func updateData(ecc: String, acc: String) {
        lblEgmCredit.text = ecc;
        txtAccountCredit.text = acc;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PasswordVC"){
            let controller = segue.destination as! PasswordVC
            controller.transferType = self.transferType
            controller.infoData = self.infoData
            controller.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let creditRootView = UIView()
        
        btnBack.snp.makeConstraints { (make) in
            make.width.equalTo(20)
            make.height.equalTo(35)
            make.top.equalTo(self.view).offset(35)
            make.left.equalTo(self.view).offset(20)
        }
        
        iconEGM.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalTo(self.view).offset(28)
            make.left.equalTo(self.view).offset(60)
        }
        
        lblAreaEgmId.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-15)
        }
        
        lblEgmCredit.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(self.view).offset(55)
            make.right.equalTo(self.view).offset(-15)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        userPhoto.snp.makeConstraints({ (make) in
            make.left.equalTo(bgView).offset(60)
            make.top.equalTo(bgView).offset(50)
            make.width.equalTo(80)
            make.height.equalTo(80)
        })
        
        
        lblUserName.snp.makeConstraints({ (make) in
            make.left.equalTo(userPhoto).offset(140)
            make.top.equalTo(bgView).offset(50)
        })
        
        lblLevel.snp.makeConstraints({ (make) in
            make.left.equalTo(userPhoto).offset(140)
            make.top.equalTo(bgView).offset(80)
        })
        
        lblAgentName.snp.makeConstraints({ (make) in
            make.left.equalTo(userPhoto).offset(140)
            make.top.equalTo(bgView).offset(110)
        })
        
        
        creditRootView.addSubview(creditBGView)
        creditRootView.addSubview(lblAccountCredit)
        creditRootView.addSubview(txtAccountCredit)
        
        self.view.addSubview(creditRootView)
        
        creditRootView.snp.makeConstraints { (make) in
            make.top.equalTo(userPhoto).offset(150)
            make.width.equalToSuperview()
        }
        
        creditBGView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(95)
        }
        
        lblAccountCredit.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.left.equalTo(100)
        }
        
        txtAccountCredit.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalTo(100)
        }
        
        btnMinus.snp.makeConstraints { (make) in
            make.top.equalTo(creditRootView).offset(160)
            make.left.equalTo(45)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        txtTransfer.layer.borderColor = UIColor.gray.cgColor
        txtTransfer.layer.borderWidth = 1
        txtTransfer.layer.cornerRadius = 30
        
        txtTransfer.snp.makeConstraints { (make) in
            make.top.equalTo(creditRootView).offset(155)
            make.center.equalTo(UIScreen.main.bounds.width/2)
            make.width.equalTo(160)
            make.height.equalTo(60)
        }
        
        btnPlus.snp.makeConstraints { (make) in
            make.top.equalTo(creditRootView).offset(160)
            make.right.equalTo(-45)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(creditRootView).offset(250)
            make.center.equalTo(UIScreen.main.bounds.width/2)
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.infoData)
        print(self.transferType)
        
        lblAreaEgmId.text = EGMData.shared.AreaEgmId
        lblEgmCredit.text = String(EGMData.shared.EgmCredit)
        lblUserName.text = EGMData.shared.UserName
        lblLevel.text = EGMData.shared.Level
        lblAgentName.text = EGMData.shared.AgentName
        txtAccountCredit.text = String(EGMData.shared.AccountCredit)
        
        let imgUrl = EGMData.shared.UserPhoto
        let url = URL(string: imgUrl!)
        let data = try! Data(contentsOf: url!)
        userPhoto.image = UIImage(data:data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
