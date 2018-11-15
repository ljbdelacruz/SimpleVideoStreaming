//
//  SignupViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 13/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignupViewController: GeneralFuncViewController {
    
    
    @IBOutlet weak var UIEmailTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    @IBOutlet weak var UIRePasswordTF: UITextField!
    var completeSignupDelegate:CompleteProcess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupAccessory();
        self.UIEmailTF.delegate=self;
        self.UIPasswordTF.delegate=self;
        self.UIRePasswordTF.delegate=self;
        self.UIEmailTF.inputAccessoryView=self.tfAccessory?.navbarAccessory;
        self.UIPasswordTF.inputAccessoryView=self.tfAccessory?.navbarAccessory;
        self.UIRePasswordTF.inputAccessoryView=self.tfAccessory?.navbarAccessory;
    }
    @IBAction func OnCreateClick(_ sender: Any) {
        self.view.endEditing(true);
        SVProgressHUD.show();
        self.view.isUserInteractionEnabled=false;
        self.navigationController?.isNavigationBarHidden=true;
        if self.UIPasswordTF!.text == self.UIRePasswordTF!.text && self.UIPasswordTF!.text!.count > 0 && self.UIEmailTF.text!.count > 0{
            FirebaseCustom.createUser(email: self.UIEmailTF.text!, password: self.UIPasswordTF.text!, completionHandler: {
                (res, err) in
                if err == nil{
                    SVProgressHUD.dismiss();
                    var user=Users(email: self.UIEmailTF.text!, password: self.UIPasswordTF.text!);
                    self.navigationController?.popViewController(animated: true);
                    self.completeSignupDelegate?.completeSignup(user: user);
                }else{
                    SVProgressHUD.dismiss();
                    guard let message=err?.localizedDescription else {
                        return;
                    }
                    self.ShowAlertMessage(title: "Error", message: message);
                }
                self.navigationController?.isNavigationBarHidden=false;
            })
        }else{
            self.ShowAlertMessage(title: "Error", message: "Please make sure to password matches the confirm password")
            self.navigationController?.isNavigationBarHidden=false;
        }
    }
}

extension SignupViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.5, moveDistance: 0, up: false);
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.5, moveDistance: 0, up: false);
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true;
    }
}
