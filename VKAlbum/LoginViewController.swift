//
//  ViewController.swift
//  VKAlbum
//
//  Created by Ринат Хабибуллин on 14.09.17.
//  Copyright © 2017 Ринат Хабибуллин. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    static var accessToken: String!
    
    @IBOutlet weak var loginWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViewConstraints()
        self.loginWebView.delegate = self
        
        let url = "https://oauth.vk.com/authorize?client_id=6116575&scope=139286&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&response_type=token&v=5.67&revoke=1"
        let urlFromString = URL(string: url)
        loginWebView.loadRequest(URLRequest(url: urlFromString!))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        var webViewResponseAfterParsing = request.url!.absoluteString.components(separatedBy: ["=", "&"])
        for answer in webViewResponseAfterParsing {
            if answer.characters.count >= 85 && answer.characters.count <= 90 {
                var accessToken = answer
                LoginViewController.accessToken = answer
                ServerManager.myServerManager.doRequest(serverRequest: ServerRequest.getUserInfo, completitionHandler: { (response) in
                    
                    User.init(userInfo: response)
                    webView.removeFromSuperview()
                    self.performSegue(withIdentifier: "AlbumCollectionViewControllerSegue", sender: self)
                })}}
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

