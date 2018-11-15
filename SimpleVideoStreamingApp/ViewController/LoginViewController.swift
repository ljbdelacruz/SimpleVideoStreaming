//
//  LoginViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import LocalAuthentication
import SVProgressHUD

class LoginViewController: GeneralFuncViewController {

    @IBOutlet weak var UIEmailTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    var userInfo:Users?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInfo=Users();
        self.SetupAccessory()
        self.UIEmailTF.delegate=self;
        self.UIPasswordTF.delegate=self;
        self.UIEmailTF.inputAccessoryView=self.tfAccessory?.navbarAccessory;
        self.UIPasswordTF.inputAccessoryView=self.tfAccessory?.navbarAccessory;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToDashboard" {
            let dest=segue.destination as! DashboardViewController;
            dest.userLoginInfo=self.userInfo;
        }else if segue.identifier == "loginToSignup"{
            let dest=segue.destination as! SignupViewController
            dest.completeSignupDelegate=self;
        }
    }
    @IBAction func LoginOnClick(_ sender: Any) {
        self.view.endEditing(true);
        self.ExecuteAuthentication();
    }
}
//MARK: Firebase Func
extension LoginViewController{
    func ExecuteAuthentication(){
        self.view.isUserInteractionEnabled=false;
        self.CheckFingerPrintScan(completionHandler: {
            (isSuccess) in
            if isSuccess! {
                SVProgressHUD.show();
                self.Autheticate(completionHandler:{
                    (isLogin) in
                    SVProgressHUD.dismiss();
                    if isLogin! {
                        self.userInfo?.set(email: self.UIEmailTF.text!, password: self.UIPasswordTF.text!)
                        //authenticate here
                        self.performSegue(withIdentifier: "loginToDashboard", sender: nil);
                    }else{
                        self.ShowAlertMessage(title: "Error", message: "Make sure to use valid username and password")
                    }
                    self.view.isUserInteractionEnabled=true;
                })
            }else{
                self.view.isUserInteractionEnabled=true;
            }
        });
    }
    func Autheticate(completionHandler: @escaping (Bool?) -> ()){
            if self.UIEmailTF.text!.count > 0 && self.UIPasswordTF.text!.count > 0 {
                FirebaseCustom.AuthUser(email: self.UIEmailTF.text!, password: self.UIPasswordTF.text!, completionHandler: {
                    (res, error) in
                    if error == nil {
                        completionHandler(true);
                    }else{
                        completionHandler(false);
                        self.ShowAlertMessage(title: "Error", message: error!.localizedDescription);
                    }
                })
            }else{
                self.ShowAlertMessage(title: "Warning", message: "Please Enter Email and Password");
            }
    }
}
//MARK: TextField func
extension LoginViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.5, moveDistance: 100, up: false);
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.5, moveDistance: 0, up: false);
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        view.endEditing(true)
        return true;
    }
    func UpdateText(email:String, password:String){
        self.UIEmailTF.text=email;
        self.UIPasswordTF.text=password
    }
}

//MARK: CompleteSignupDelegate
extension LoginViewController:CompleteProcess{
    func completeSignup(user: Users) {
        self.userInfo?.set(email: user.email, password: user.password);
        self.UpdateText(email: self.userInfo!.email, password: self.userInfo!.password)
        self.ExecuteAuthentication()
    }
}

