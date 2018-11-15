//
//  Episodes.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase

class Episodes{
    var id,source,title:String;
    init(){
        self.source="";
        self.title="";
        self.id="";
    }
    func set(id:String,source:String, title:String){
        self.source=source;
        self.title=title;
        self.id=id;
    }
    
    //MARK: static methods
    static func all(animeTitle:String, completionHandler: @escaping (Episodes?, String?) -> ()){
        let db=Database.database().reference().child("Anime").child(animeTitle).child("episodes");
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            guard let dict=ds!.value as! Dictionary<String, Any>? else{
                completionHandler(nil, "Cannot Fetch data please make sure you are connected to the internet")
                return
            }
            completionHandler(self.Setup(key:ds!.key, dict: dict), nil);
        })
    }
    static func Setup(key:String, dict:[String:Any])->Episodes{
        let temp=Episodes();
        temp.set(id:key, source: dict["source"] as! String, title: dict["title"] as! String);
        return temp;
    }
}
