//
//  SearchByEgmIdVC.swift
//  EgmService
//
//  Created by David on 13/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchByEgmIdVC: UIViewController {
    var infoData:JSON?
    @IBOutlet weak var btnBack: UIButton!
    @IBAction func backToEgmView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var lblAreaEgmId: UILabel!
    @IBOutlet weak var lblEgmCredit: UILabel!
    @IBOutlet weak var txtCoinIn: UITextField!
    @IBOutlet weak var txtCoinOut: UITextField!
    @IBOutlet weak var txtAFTIn: UITextField!
    @IBOutlet weak var txtAFTOut: UITextField!
    @IBOutlet weak var txtTotalDrop: UITextField!
    @IBOutlet weak var txtTotalCancelCredit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let img = UIImage(named: "cherries")
        self.navigationController?.navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target:self, action: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        print(self.infoData)
        lblAreaEgmId.text = (self.infoData?["EIF"]["ARE"].stringValue)! + "-" + (self.infoData?["EI"].stringValue)!
        lblEgmCredit.text = self.infoData?["EIF"]["CC"].stringValue
        txtCoinIn.text = self.infoData?["EIF"]["CI"].stringValue
        txtCoinOut.text = self.infoData?["EIF"]["CO"].stringValue
        txtAFTIn.text = self.infoData?["EIF"]["AI"].stringValue
        txtAFTOut.text = self.infoData?["EIF"]["AO"].stringValue
        txtTotalDrop.text = self.infoData?["EIF"]["TD"].stringValue
        txtTotalCancelCredit.text = self.infoData?["EIF"]["TCC"].stringValue
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
