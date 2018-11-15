//
//  GeneralFuncViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 13/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import LocalAuthentication

class GeneralFuncViewController: UIViewController {

    weak var tfAccessory:TFAccessory?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfAccessory=TFAccessory(view: self.view);
        // Do any additional setup after loading the view.
    }
    func ShowAlertMessage(title:String, message:String){
        let uialert=MyCustomAlert.ShowAlert(title: title, message: message);
        present(uialert, animated: true, completion: nil)
    }
}
//MARK: TF Accessory
extension GeneralFuncViewController{
    func SetupAccessory(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done
            ,target: self, action: #selector(CloseKeyboard))
        doneButton.tintColor=UIColor.white
        self.tfAccessory?.setupButton(button: doneButton, position: .rightitem);
    }
    @objc func CloseKeyboard(){
        view.endEditing(true)
    }
}
//MARK: Biometrics scanner
extension GeneralFuncViewController{
    func CheckFingerPrintScan(completionHandler: @escaping (Bool?) -> ()){
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        var authError: NSError?
        let reasonString = "To access the secure data"
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                if success {
                    completionHandler(true);
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        completionHandler(false);
                        return
                    }
                    completionHandler(false);
                }
            }
        } else {
            guard let error = authError else {
                return
            }
            //Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            self.ShowAlertMessage(title: "Error", message: error.localizedDescription);
        }
    }
}

//extension AlertActionSheet
extension GeneralFuncViewController{
    func CreateActionSheet(message:String, completionHandler: @escaping () -> ()){
        let uialert=MyCustomAlert.ShowActionSheet(title: "Fetched data from QR Code", message: message, completionHandler:completionHandler)
        present(uialert, animated: true, completion: nil)
    }
}
