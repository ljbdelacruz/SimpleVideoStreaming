//
//  MyCustomFirebase.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 12/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation

import Foundation
import Firebase


class FirebaseCustom{
    static func createUser(email:String, password:String, completionHandler: @escaping (Any?, Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if error==nil{
                //success user created
                completionHandler(user, nil);
            }else{
                //print error
                completionHandler(nil, error);
            }
        })
    }
    static func AuthUser(email:String, password:String, completionHandler: @escaping (Any?, Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (response, error) in
            if error==nil{
                completionHandler(response, nil);
            }else{
                completionHandler(nil, error);
            }
        })
    }
    func Logout(completionHandler: @escaping (Bool) -> ()){
        do{
            try Auth.auth().signOut()
            completionHandler(true)
        }catch{
            completionHandler(false);
        }
    }
    func InsertData(data:Any?, db:DatabaseReference, completionHandler: @escaping (Any?, Error?) -> ()){
        //        let messageDB=Database.database().reference().child(name);
        db.childByAutoId().setValue(data!){
            (error, ref) in
            if error == nil{
                completionHandler(ref, nil);
            }else{
                completionHandler(nil, error as! Error);
            }
        }
    }
    
    func RetrieveDataValue(db:DatabaseReference, completionHandler: @escaping (DataSnapshot?) -> ()){
        //        let messageDB=Database.database().reference().child(name);
        db.observe(.childAdded, with: {
            (response) in
            completionHandler(response);
        })
    }
}




