//
//  Episodes.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation

class Episodes{
    var source,title:String;
    init(){
        self.source="";
        self.title="";
    }
    func set(source:String, title:String){
        self.source=source;
        self.title=title;
    }
}
