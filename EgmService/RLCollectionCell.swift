//
//  RLCollectionCell.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/18.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit

class RLCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblAgentName: UILabel!
    @IBOutlet weak var lblCashCredit: UILabel!
    @IBOutlet weak var txtCashCredit: UITextField!
    @IBOutlet weak var lblLastLogin: UILabel!
    @IBOutlet weak var txtLastLogin: UITextField!
    @IBOutlet weak var lblRestrictedCredit: UILabel!
    @IBOutlet weak var txtRestrictedCredit: UITextField!
    @IBOutlet weak var lblNonRestrictedCredit: UILabel!
    @IBOutlet weak var txtNonRestrictedCredit: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnTransferToEgm: UIButton!
    @IBOutlet weak var btnTransferToAcc: UIButton!
    @IBOutlet weak var btnSearchPlayer: UIButton!
    @IBOutlet weak var txtSearchPlayer: UITextField!
    
}
