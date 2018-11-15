//
//  Users.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation


class Users{
    var email, password:String
    init(){
        self.email="";
        self.password="";
    }
    convenience init(email:String, password:String){
        self.init();
        self.set(email: email, password: password);
    }
    func set(email:String, password:String){
        self.email=email;
        self.password=password;
    }
    static func CreateNewUser(email:String, password:String, completionHandler: @escaping (Any?, Error?) -> ()){
        
    }
    
    
    
    
}
