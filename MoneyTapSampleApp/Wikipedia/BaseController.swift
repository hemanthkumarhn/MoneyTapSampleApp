//
//  BaseController.swift
//  MoneyTapSampleApp
//
//  Created by hemanth kumar on 19/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import Foundation
import UIKit

class BaseController:UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var search:UISearchBar!
     @IBOutlet weak var errorLabel:UILabel!

    @IBAction func searchAction (_ sender:Any) {
        if (search.text?.count)! >= 1 {
            errorLabel.isHidden = true
            setSearchUserDefault(searchTextValue!)
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Please enter the string or character";
        }
    }
    var searchTextValue:String? = nil
    var util = utility()

    override func viewDidLoad()
    {
        search.delegate = self
        errorLabel.isHidden = true
        searchButton.isEnabled = false
    }
}
extension BaseController : UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if (search.text?.count)! >= 1 {
            searchButton.sendActions(for: .touchUpInside)
        }
         else
        {
            errorLabel.isHidden = false
            errorLabel.text = "Please enter the string or character";
        }
        print("searchBarSearchButtonClicked")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchTextValue = searchText
        if searchText.count >= 1 {
            searchButton.isEnabled = true
        }
    }
    func setSearchUserDefault(_ searchText:String) {
        UserDefaults.standard.set(searchTextValue, forKey: "searchText")
    }
}
