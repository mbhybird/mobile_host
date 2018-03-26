//
//  SearchByPlayerIdVC.swift
//  EgmService
//
//  Created by David on 13/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchByPlayerIdVC: UIViewController {
    
    var infoData:JSON?
    
    @IBOutlet weak var lblAreaEgmId: UILabel!
    @IBOutlet weak var lblEgmCredit: UILabel!
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
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "TransferVC") as! TransferVC
        vc.infoData = self.infoData
        vc.transferType = "EGM"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func transferToAcc(){
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "TransferVC") as! TransferVC
        vc.infoData = self.infoData
        vc.transferType = "ACC"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backToPlayerView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        
        print(self.infoData)
        
        lblAreaEgmId.text = (self.infoData?["EIF"]["ARE"].stringValue)! + "-" + (self.infoData?["EIF"]["EI"].stringValue)!
        lblEgmCredit.text = self.infoData?["EIF"]["CC"].stringValue
        lblUserName.text = self.infoData?["MIF"]["N"].stringValue
        lblLevel.text = self.infoData?["MIF"]["L"].stringValue
        lblAgentName.text = self.infoData?["MIF"]["AN"].stringValue
        txtAccountCredit.text = self.infoData?["MIF"]["AC"].stringValue
        txtLastLogin.text = self.infoData?["MIF"]["LLT"].stringValue
        
        let imgUrl = self.infoData?["MIF"]["IMG"].stringValue
        let url = URL(string: imgUrl!)
        let data = try! Data(contentsOf: url!)
        userPhoto.image = UIImage(data:data)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(ecc: String, acc: String) {
        lblEgmCredit.text = ecc;
        txtAccountCredit.text = acc;
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
