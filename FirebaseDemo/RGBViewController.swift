//
//  RGBViewController.swift
//  FirebaseDemo
//
//  Created by TANG,QI-RONG on 2020/9/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import UIKit
import Firebase
import Color_Picker_for_iOS

class RGBViewController: UIViewController {

    var RGBreference: DatabaseReference!
    let RGBPickerView = HRColorPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RGBPickerView.frame = view.frame
        RGBPickerView.frame.origin.y = 30
        RGBPickerView.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        view.addSubview(RGBPickerView)
        RGBreference = Database.database().reference(withPath: "RGB")
        RGBreference.observeSingleEvent(of: .value) { (dataSnapshop) in
            let colorValue = dataSnapshop.value as! [String: Float]
            let R = colorValue["R"]!
            let G = colorValue["G"]!
            let B = colorValue["B"]!
            self.RGBPickerView.color = UIColor(displayP3Red: CGFloat(R/255.0), green: CGFloat(G/255.0), blue: CGFloat(B/255.0), alpha: 1)
            
        }
    }
    
    @objc func changeColor(_ sender: HRColorPickerView) {
        
        var rValue = CGFloat(0.0)
        var gValue = CGFloat(0.0)
        var bValue = CGFloat(0.0)
        var alphaValus = CGFloat(0.0)
        sender.color.getRed(&rValue, green: &gValue, blue: &bValue, alpha: &alphaValus)
        RGBreference.setValue(["R": Int(rValue * 255), "G": Int(gValue * 255), "B": Int(bValue * 255)])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
