//
//  MyQRCodeVC.swift
//  EgmService
//
//  Created by David on 05/07/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import swiftScan

class MyQRCodeVC: LBXScanViewController  {

    var bottomItemsView:UIView?
    
    var btnBack:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        drawScanView()
        drawBottomItems();
        
        if(!Platform.isSimulator){
            perform(#selector(LBXScanViewController.startScan), with: nil, afterDelay: 0.3)
        }
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

    func backToSearchRoot(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func drawBottomItems(){
        if (bottomItemsView != nil) {
            
            return;
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame:CGRect(x: 0.0, y: yMax - 100,width: self.view.frame.size.width, height: 100 ) )
        
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        
        let size = CGSize(width: 100, height: 100);
        
        self.btnBack = UIButton()
        btnBack.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnBack.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        //btnBack.setImage(UIImage(named: "backBtn"), for:UIControlState.normal)
        btnBack.setTitle("Cancel", for: UIControlState.normal)
        btnBack.tintColor = UIColor.white
        btnBack.addTarget(self, action: #selector(MyQRCodeVC.backToSearchRoot), for: UIControlEvents.touchUpInside)
        
        
        bottomItemsView?.addSubview(btnBack)
        
        self.view.addSubview(bottomItemsView!)
    }
}
