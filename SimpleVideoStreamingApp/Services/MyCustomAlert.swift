//
//  MyCustomAlert.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 12/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import UIKit


public class MyCustomAlert{
    private init(){}
    public static func CreateAlert(title:String, message:String)->UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    public static func ShowAlert(title:String, message:String)->UIAlertController{
        let uialert=self.CreateAlert(title: title, message: message);
        let okAction=UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
        })
        uialert.addAction(okAction);
        return uialert;
    }
    public static func ShowActionSheet(title:String, message:String, completionHandler: @escaping () -> ())->UIAlertController{
        let alertPrompt = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            completionHandler()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        return alertPrompt;
    }
    
}
