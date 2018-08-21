//
//  RestInterface.swift
//  MoneyTapSampleApp
//
//  Created by hemanth kumar on 19/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import Foundation
import UIKit

class RestInterface:NSObject {

    private let util  = utility()
    private let restConnector = RestConnetor()
    private let dataParse = dataParser()

    func add(i:Int, j:Int) ->Int{
        return i+j
    }
func searchCall(searchText: String,completionHandler: @escaping (_ response: [searchModel]) -> ())
{
    var searchUrl = util.getSearchUrl()

    searchUrl = searchUrl?.replacingOccurrences(of:"gpssearch=" , with:"gpssearch="+searchText)
    searchUrl = searchUrl?.replacingOccurrences(of:" " , with:"_")

    let  request         = URLRequest(url: URL(string:searchUrl!)!) as! NSMutableURLRequest
    
    restConnector.restCall(request: request, completionHandler: { result, error in
        if error != nil {
            completionHandler([])
        }
        else
        {
             let res:[searchModel] = self.dataParse.searchDataParser(response: result! as! [String : Any])!
            completionHandler(res)
        }
    })
}
}
