//
//  utility.swift
//  MoneyTapSampleApp
//
//  Created by hemanth kumar on 20/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import Foundation

final class utility {

    func getSearchUrl()->String? {
        if let path = Bundle.main.path(forResource: "WebServices", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            guard let _ = dict["search"] else {
                return ""
            }
            return dict["search"] as? String
        }
        return ""
    }
    func getAdvanceSearchUrl()->String? {
        if let path = Bundle.main.path(forResource: "WebServices", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            guard let _ = dict["advanceSearch"] else {
                return ""
            }
            return dict["advanceSearch"] as? String
        }
        return ""
    }
}
