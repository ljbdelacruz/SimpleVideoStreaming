//
//  LoginViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var UIEmailTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    var userInfo:Users?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInfo=Users();
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let dest=segue.destination as! DashboardViewController;
            
        }
    }
    
    @IBAction func LoginOnClick(_ sender: Any) {
        
        
    }
    
}
