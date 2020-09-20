//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by TANG,QI-RONG on 2020/9/15.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var lightbulb: DatabaseReference!
    
    @IBOutlet weak var lightbulbOutlet: UIButton!
    
    @IBAction func lightSwitchButton(_ sender: UIButton) {
        lightbulb.observeSingleEvent(of: .value) { (dataSnapshop) in
            let bulbState = dataSnapshop.value as! Bool
            self.lightbulb.setValue(!bulbState)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lightbulb = Database.database().reference(withPath: "light/Switch on")
        lightbulb.observe(.value) { (dataSnapshop) in
            let bulbState = dataSnapshop.value as! Bool
            if bulbState {
                self.navigationItem.prompt = "狀態：燈亮"
                self.lightbulbOutlet.setImage(UIImage(named: "lightOn"), for: .normal)
            }else {
                self.navigationItem.prompt = "狀態：關燈"
                self.lightbulbOutlet.setImage(UIImage(named: "lightOff"), for: .normal)
            }
                
        }
    }


}

