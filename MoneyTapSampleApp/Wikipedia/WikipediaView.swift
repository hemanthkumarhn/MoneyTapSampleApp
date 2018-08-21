//
//  WikipediaView.swift
//  MoneyTapSampleApp
//
//  Created by hemanth kumar on 19/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import Foundation
import WebKit

class WikipediaView:UIViewController,UIWebViewDelegate
{
    @IBOutlet weak var webView:WKWebView!
    @IBOutlet weak var errorLabel:UILabel!

    private let util = utility()

    override func viewDidLoad()
    {
        if let val:String = UserDefaults.standard.object(forKey: "advanceSearch") as? String
        {
            errorLabel.isHidden = true
            webView.isHidden    = false

            var urlPath = util.getAdvanceSearchUrl()
            urlPath = urlPath?.replacingOccurrences(of: "title", with: val)
            urlPath = urlPath?.replacingOccurrences(of: " ", with: "_")
            let request = NSURLRequest(url: URL(string: urlPath!)!)
            self.webView.navigationDelegate = self as? WKNavigationDelegate
            
            webView.load(request as URLRequest)
        } else {
            errorLabel.isHidden = false
            webView.isHidden = true
        }
    }
}
