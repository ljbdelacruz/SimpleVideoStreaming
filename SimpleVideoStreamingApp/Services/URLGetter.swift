//
//  URLGetter.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import UIKit

class URLGetter{
    static func toURL(url:String)->URL{
        return URL(string: url)!;
    }
    static func toURLReq(url:URL)->URLRequest{
        return URLRequest(url: url);
    }
    static func fetchImage(url:String)->UIImage{
        if(url != nil){
            let data = try? Data(contentsOf: self.toURL(url: url));
            if let imageData = data {
                return UIImage(data: imageData)!;
            }else{
                return UIImage(named: "nimage")!
            }
        }
        return UIImage(named: "nimage")!
    }
    
    
}
