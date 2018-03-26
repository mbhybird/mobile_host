//
//  RLAlwaysOnTopHeader.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/18.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit
import SnapKit
import SocketIO

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

class RLAlwaysOnTopHeader: UICollectionReusableView,UITextFieldDelegate{

    //@IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblAreaEgmId: UILabel!
    @IBOutlet weak var lblEgmCredit: UILabel!
    @IBOutlet weak var lblCoinIn: UILabel!
    @IBOutlet weak var lblCoinOut: UILabel!
    @IBOutlet weak var lblAFTIn: UILabel!
    @IBOutlet weak var lblAFTOut: UILabel!
    @IBOutlet weak var lblTotalDrop: UILabel!
    @IBOutlet weak var lblTotalCancelCredit: UILabel!
    @IBOutlet weak var txtCoinIn: UITextField!
    @IBOutlet weak var txtCoinOut: UITextField!
    @IBOutlet weak var txtAFTIn: UITextField!
    @IBOutlet weak var txtAFTOut: UITextField!
    @IBOutlet weak var txtTotalDrop: UITextField!
    @IBOutlet weak var txtTotalCancelCredit: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var iconEGM: UIImageView!
    var viewRoot:UIView!
    @IBOutlet weak var txtSearchEGM: UITextField!
    @IBOutlet weak var btnSearchEGM: UIButton!
    var egmId:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnBack.snp.makeConstraints { (make) in
            make.width.equalTo(20)
            make.height.equalTo(35)
            make.top.equalTo(self.subviews[0]).offset(15)
            make.left.equalTo(self.subviews[0]).offset(20)
        }
        
        iconEGM.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalTo(self.subviews[0]).offset(8)
            make.left.equalTo(self.subviews[0]).offset(60)
        }
        
        viewRoot = UIView()
        self.subviews[0].addSubview(viewRoot)
        viewRoot.addSubview(lblCoinIn)
        viewRoot.addSubview(lblCoinOut)
        viewRoot.addSubview(lblAFTIn)
        viewRoot.addSubview(lblAFTOut)
        viewRoot.addSubview(lblTotalDrop)
        viewRoot.addSubview(lblTotalCancelCredit)
        viewRoot.addSubview(txtCoinIn)
        viewRoot.addSubview(txtCoinOut)
        viewRoot.addSubview(txtAFTIn)
        viewRoot.addSubview(txtAFTOut)
        viewRoot.addSubview(txtTotalDrop)
        viewRoot.addSubview(txtTotalCancelCredit)
        
        viewRoot.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(self.subviews[0]).offset(30)
        }
        
        let view1 = UIView()
        view1.layer.borderColor = UIColor.gray.cgColor
        view1.layer.borderWidth = 1
        
        viewRoot.addSubview(view1)
        
        let view2 = UIView()
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.borderWidth = 1
        
        viewRoot.addSubview(view2)
        
        let view3 = UIView()
        view3.layer.borderColor = UIColor.gray.cgColor
        view3.layer.borderWidth = 1
        
        viewRoot.addSubview(view3)
        
        let view4 = UIView()
        view4.layer.borderColor = UIColor.gray.cgColor
        view4.layer.borderWidth = 1
        
        viewRoot.addSubview(view4)
        
        let view5 = UIView()
        view5.layer.borderColor = UIColor.gray.cgColor
        view5.layer.borderWidth = 1
        
        viewRoot.addSubview(view5)
        
        let view6 = UIView()
        view6.layer.borderColor = UIColor.gray.cgColor
        view6.layer.borderWidth = 1
        
        viewRoot.addSubview(view6)
        
        
        view1.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(viewRoot).offset(60)
            make.left.equalTo(viewRoot).offset(0)
        }
        
        view2.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(viewRoot).offset(110)
            make.left.equalTo(viewRoot).offset(0)
        }

        view3.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(viewRoot).offset(190)
            make.left.equalTo(viewRoot).offset(0)
        }
        
        view4.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(viewRoot).offset(270)
            make.left.equalTo(viewRoot).offset(0)
        }
        
        view5.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(viewRoot).offset(350)
            make.left.equalTo(viewRoot).offset(0)
        }
        
        /*
        let modelName = UIDevice.current.modelName
        var centerX = 190
        if(modelName.range(of:"Plus") != nil){
            //iPhone Plus
            centerX = 210
        }*/
        
        view6.snp.makeConstraints { (make) in
            make.height.equalTo(240)
            make.width.equalTo(1)
            make.top.equalTo(viewRoot).offset(110)
            make.left.equalTo(UIScreen.main.bounds.width/2)
        }
        
        lblCoinIn.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(120)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        txtCoinIn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(150)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        lblAFTOut.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(120)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        txtAFTOut.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(150)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        lblCoinOut.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(200)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        txtCoinOut.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(230)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        lblTotalDrop.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(200)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        txtTotalDrop.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(230)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        lblAFTIn.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(280)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        txtAFTIn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(310)
            make.left.equalTo(viewRoot).offset(30)
        }
        
        lblTotalCancelCredit.snp.makeConstraints { (make) in
            make.top.equalTo(viewRoot).offset(280)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        txtTotalCancelCredit.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(viewRoot).offset(310)
            make.left.equalTo(viewRoot).offset(UIScreen.main.bounds.width/2+30)
        }
        
        if(EGMData.shared.AreaEgmId != ""){
            lblEgmCredit.text = String(EGMData.shared.EgmCredit)
            lblAreaEgmId.text = EGMData.shared.AreaEgmId
            txtCoinIn.text = String(EGMData.shared.CoinIn)
            txtCoinOut.text = String(EGMData.shared.CoinOut)
            txtAFTIn.text = String(EGMData.shared.AFTIn)
            txtAFTOut.text = String(EGMData.shared.AFTOut)
            txtTotalDrop.text = String(EGMData.shared.TotalDrop)
            txtTotalCancelCredit.text = String(EGMData.shared.TotalCacelCredit)
            
            btnSearchEGM.isHidden = true
            txtSearchEGM.isHidden = true
            lblAreaEgmId.isHidden = false
            lblEgmCredit.isHidden = false
            
            lblAreaEgmId.snp.makeConstraints { (make) in
                make.width.equalTo(100)
                make.top.equalTo(self.subviews[0]).offset(15)
                make.right.equalTo(self.subviews[0]).offset(-15)
            }
            
            lblEgmCredit.snp.makeConstraints { (make) in
                make.width.equalTo(100)
                make.top.equalTo(self.subviews[0]).offset(40)
                make.right.equalTo(self.subviews[0]).offset(-15)
            }
            
        }
        else{
            lblAreaEgmId.isHidden = true
            lblEgmCredit.isHidden = true
            btnSearchEGM.isHidden = false
            txtSearchEGM.isHidden = false
            
            txtSearchEGM.layer.cornerRadius = 15
            txtSearchEGM.layer.borderColor = UIColor.gray.cgColor
            txtSearchEGM.layer.borderWidth = 1
            
            txtSearchEGM.snp.makeConstraints { (make) in
                make.top.equalTo(self.subviews[0]).offset(10)
                make.left.equalTo(iconEGM).offset(65)
                make.width.equalTo(160)
                make.height.equalTo(50)
            }
            
            btnSearchEGM.snp.makeConstraints { (make) in
                make.top.equalTo(self.subviews[0]).offset(10)
                make.left.equalTo(iconEGM).offset(240)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            
            txtSearchEGM.addTarget(self, action: #selector(egmIdChanged(sender:)), for: .editingChanged)
            txtSearchEGM.delegate = self
            btnSearchEGM.addTarget(self, action: #selector(searchByEgmId), for: .touchUpInside)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtSearchEGM.resignFirstResponder()
    }

    
    func searchByEgmId(){
        print(#function.description)
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.GET_EGM_INFO.rawValue, ["R" : 1004, "EI": self.egmId ])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.superview?.parentViewController?.present(alertController, animated: true, completion: nil)
            //UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func egmIdChanged(sender:UITextField){
        self.egmId = sender.text ?? ""
    }
    
    override func apply(_ _layoutAttributes: UICollectionViewLayoutAttributes) {
        
        let layoutAttributes = _layoutAttributes as? RLStickyHeaderFlowLayoutAttributes
        
        UIView.animate(withDuration: 0.2, animations: {
            
            
            if layoutAttributes!.progressiveness <= 0.58 {
                //self.titleLabel.alpha = 1
            } else {
                //self.titleLabel.alpha = 0
            }
            
            if layoutAttributes!.progressiveness >= 1 {
                self.viewRoot.alpha = 1
            } else {
                self.viewRoot.alpha = 0
            }
            
        }) 
    }
    
}
