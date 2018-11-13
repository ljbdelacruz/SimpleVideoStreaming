//
//  DashboardViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 10/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var userLoginInfo:Users?
    var animeList:[AnimeInfo]?;
    var selectedAnime:AnimeInfo?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(userLoginInfo?.email);
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Disappear");
        self.userLoginInfo=nil;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animeToviewInfo" {
            let destVC=segue.destination as! ViewAnimeInfoViewController;
            destVC.animeInfo=self.selectedAnime;
            destVC.userInfo=self.userLoginInfo;
        }
    }
    @IBAction func OnQRScan(_ sender: Any) {
        performSegue(withIdentifier: "dashboardToQRScanner", sender: nil);
    }
    
    
    
    
    
}
