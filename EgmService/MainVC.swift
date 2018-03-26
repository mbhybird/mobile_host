//
//  ViewController.swift
//  EgmService
//
//  Created by David on 10/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import SocketIO

class MainVC: BaseVC, UITextFieldDelegate {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var motixLogo: UIImageView!
    @IBOutlet weak var loginButton:UIButton!
    
    func loginAction(){
        if(SocketIOHelper.shared.socket.status == SocketIOClientStatus.connected){
            SocketIOHelper.shared.socket.emit(Emit.MOTIX_LOGIN.rawValue,
                                              ["R" : 1001,"UN": userNameField.text!,"P" : passwordField.text!])
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Server is not connected", preferredStyle:UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //SocketIOHelper.shared.socket.removeAllHandlers();
        SocketIOHelper.shared.socket.on(On.MOTIX_LOGIN_RESULT.rawValue){data, ack in
            let json = JSON(data[0])
            if(json["EC"] == 0){
                /*
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController : UIViewController = storyboard.instantiateViewController(withIdentifier: "SearchRootVC")
                self.present(viewController, animated: true, completion: nil)*/
                self.navigationController?.performSegue(withIdentifier: "SearchRootVC", sender: self)

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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view, typically from a nib.
        
        let myView = UIView()
        passwordField.isSecureTextEntry = true
        //loginButton.setTitle("Login", for: UIControlState.normal)
        //loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        loginButton.addTarget(self, action:#selector(loginAction), for: UIControlEvents.touchUpInside)
      
        myView.addSubview(motixLogo)
        myView.addSubview(loginButton)
        myView.addSubview(userNameField)
        myView.addSubview(passwordField)
        
        //myView.backgroundColor = UIColor.purple
        self.view.addSubview(myView)
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(80)
            make.top.equalTo(myView).offset(500)
            make.left.equalTo(myView).offset(100)
            make.right.equalTo(myView).offset(-100)
        }
        
        motixLogo.snp.makeConstraints{ make in
            make.bottom.equalTo(myView).offset(-50)
            make.left.equalTo(myView).offset(20)
            make.right.equalTo(myView).offset(-20)
            
        }
        
        userNameField.layer.borderColor = UIColor.gray.cgColor
        userNameField.layer.borderWidth = 1
        userNameField.layer.cornerRadius = 20
        let attrStringForUN = NSAttributedString(string:"Email",attributes:[NSForegroundColorAttributeName: UIColor.gray])
        userNameField.attributedPlaceholder = attrStringForUN
        
        userNameField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(myView).offset(350)
            make.left.equalTo(myView).offset(50)
            make.right.equalTo(myView).offset(-50)
        }
        
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 20
        let attrStringForPWD = NSAttributedString(string:"Password",attributes:[NSForegroundColorAttributeName: UIColor.gray])
        passwordField.attributedPlaceholder = attrStringForPWD
        
        passwordField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(myView).offset(400)
            make.left.equalTo(myView).offset(50)
            make.right.equalTo(myView).offset(-50)
        }
        
        
        /*
        loginButton.snp.makeConstraints { (make) in
            
            let modelName = UIDevice.current.modelName
            if(modelName.range(of:"iPod") != nil){
                //iPod
                make.bottom.equalTo(myView).offset(-100)
            }
            else{
                //iPhone
                make.bottom.equalTo(myView).offset(-200)
            }
            make.left.equalTo(myView).offset(100)
            make.right.equalTo(myView).offset(-100)
        }*/
        
        
        myView.snp.makeConstraints{ (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        userNameField.delegate = self
        passwordField.delegate = self
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.userNameField{
            userNameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            
        } else {
            passwordField.resignFirstResponder()
            
        }
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

