//
//  ViewAnimeInfoViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import WebKit


class ViewAnimeInfoViewController: UIViewController {

    
    weak var animeInfo:AnimeInfo?;
    weak var userInfo:Users?;
    @IBOutlet weak var WKDisplayVideo: WKWebView!
    @IBOutlet weak var UIScrollView: UIScrollView!
    @IBOutlet weak var UIBackgroundImage: UIImageView!
    @IBOutlet weak var UIProfileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            self.UIBackgroundImage.image=URLGetter.fetchImage(url: self.animeInfo!.backgroundImg);
            self.UIProfileImage.image=URLGetter.fetchImage(url: self.animeInfo!.profileImg);
        }
    }
    
    
}
