//
//  AnimeInfo.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase

class AnimeInfo{
    
    var id, name, profileImg, backgroundImg:String;
    init(){
        self.id="";
        self.name="";
        self.profileImg="";
        self.backgroundImg="";
    }    
    func set(id:String, name:String, profileImg:String, backgroundImg:String){
        self.profileImg=profileImg;
        self.backgroundImg=backgroundImg;
        self.id=id;
        self.name=name;
    }
    //MARK: Static func
    static func all(completionHandler: @escaping (AnimeInfo?, String?) -> ()){
        let db=Database.database().reference().child("Anime");
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            guard let dict=ds!.value as! Dictionary<String, Any>? else{
                completionHandler(nil, "Cannot Fetch data please make sure you are connected to the internet")
                return
            }
            completionHandler(AnimeInfo.Setup(key:ds!.key, dict: dict), nil);
        })
    }
    
    static func Setup(key:String, dict:[String:Any])->AnimeInfo{
        let temp=AnimeInfo();
        temp.set(id:key, name: dict["title"] as! String, profileImg: dict["pimage"] as! String, backgroundImg: dict["bgimage"] as! String)
        print(temp.name)
        return temp;
    }
    
    
}
