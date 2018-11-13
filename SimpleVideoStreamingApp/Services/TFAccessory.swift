//
//  TFAccessory.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 12/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//
import Foundation
import UIKit

enum AccessoryTF{
    case rightitem
    case leftitem
}
class TFAccessory{
    var navbarAccessory:UINavigationBar?;
    private var navItem = UINavigationItem()
    init(view:UIView){
        self.TFSetup(view:view)
    }
    func TFSetup(view:UIView){
        DispatchQueue.global(qos:.userInitiated).async {
            [weak self] in
        }
        
        self.navbarAccessory = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navbarAccessory!.barStyle = UIBarStyle.blackTranslucent;
        navbarAccessory!.backgroundColor = UIColor.cyan;
        navbarAccessory!.alpha = 0.9;
        //replace viewWidth with view controller width
        navItem = UINavigationItem()
    }
    func setupButton(button:UIBarButtonItem, position:AccessoryTF){
        if position == .rightitem{
            navItem.rightBarButtonItem=button;
        }
        navbarAccessory!.pushItem(navItem, animated: false)
    }
}
