//
//  AnimeInfo.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation


class AnimeInfo{
    var name, profileImg, backgroundImg:String;
    init(){
        self.name="";
        self.profileImg="";
        self.backgroundImg="";
    }    
    func set(name:String, profileImg:String, backgroundImg:String){
        self.name=name;
        self.profileImg=profileImg;
        self.backgroundImg=backgroundImg;
    }
}
