//
//  BaseViewController.swift
//  EgmService
//
//  Created by David on 11/06/2017.
//  Copyright © 2017 motix. All rights reserved.
//

import UIKit
//import SocketIO

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}

class BaseVC: UIViewController {
    //let socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(false), .forcePolling(false)])
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    public func login(userName:String,password:String)->Bool{
        socket.emit("motixLogin", ["userName": userName,"password":password])
        return true;
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.onAny {print("got event: \($0.event) with items \($0.items)")}
        
        
        socket.emit("motixLogin", ["userName": "user1","password":"123456"])
        
        
        socket.on("motixLoginResult"){data, ack in
            print(data)
        }
        
        socket.connect()
        */
    }


}
