//
//  URLVideoViewController.swift
//  SimpleVideoStreamingApp
//
//  Created by Lainel John Dela Cruz on 13/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import WebKit

class URLVideoViewController: UIViewController, WKUIDelegate {
    weak var UIWKVideo: WKWebView!
    @IBOutlet weak var UIVideoDisplay: UIView!
    var viewResponseDelegate:CloseViewResponseDelegate?;
    var url:URL?
    override func viewDidLoad(){
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        UIWKVideo = WKWebView(frame: .zero, configuration: webConfiguration)
        UIWKVideo.frame=self.UIVideoDisplay.frame;
        UIWKVideo.uiDelegate = self
        UIWKVideo.load(URLGetter.toURLReq(url: url!));
        self.UIVideoDisplay.addSubview(UIWKVideo);
    }
    @IBAction func BackOnClick(_ sender: Any) {
        self.viewResponseDelegate?.ExecuteWhenClose()
        self.navigationController?.popViewController(animated: true);
    }
    
    
}
