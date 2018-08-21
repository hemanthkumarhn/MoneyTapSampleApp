//
//  ViewController.swift
//  MoneyTapSampleApp
//
//  Created by hemanth kumar on 19/08/18.
//  Copyright © 2018 MoneyTapSample. All rights reserved.
//

import UIKit

class WikipediaViewController: UIViewController
{
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak var search:UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorLabel:UILabel!

    private let restInterface = RestInterface()
    private let util          = utility()

    var dataSource:[searchModel] = [searchModel]()

    // Doing search call to fetch the response
    fileprivate func doSearchCall() {
        self.errorLabel.isHidden = true
        self.activityIndicator.isHidden = false
        restInterface.searchCall(searchText: search.text!, completionHandler:{ response in
            self.dataSource = response
            // store the data in the data source for binding the collection view
            if self.dataSource.count>0
            {
                DispatchQueue.main.async {
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                }
            } else
            { // If data is not available , show the no data label message
                 DispatchQueue.main.async {
                    self.errorLabel.isHidden = false
                    self.activityIndicator.isHidden = true
                    self.collectionView.isHidden = true
                }
            }
        })
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        search.delegate            = self
        collectionView.isHidden    = true
        errorLabel.isHidden        = true
        activityIndicator.isHidden = false

        //read the search string
        search.text = UserDefaults.standard.object(forKey: "searchText") as? String

        //do setup cell id for collection view
        self.collectionView.register(UINib(nibName: "WikipediaCell", bundle: nil), forCellWithReuseIdentifier: "WikiCell")

        doSearchCall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension WikipediaViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:WikipediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WikiCell", for: indexPath) as! WikipediaCell
        let searchDetails:searchModel = dataSource[indexPath.row]
        
        cell.title.text             = searchDetails.title
        cell.detailDescription.text = searchDetails.discreption

        if searchDetails.thumbnail != nil{
            let imageData = try! Data(contentsOf: URL(string: searchDetails.thumbnail!)!)
            cell.thumbImage.image   = UIImage(data: imageData)
        }
        else { //Default thumbnail
            cell.thumbImage.image = UIImage(named: "noImageAvailableSmall")
        }
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //On clic we are launching the advance search webview
        let searchDetails = dataSource[indexPath.row]
        UserDefaults.standard.setValue(searchDetails.title, forKey:"advanceSearch")
        let storageVC = self.storyboard?.instantiateViewController(withIdentifier: "advancesearch_webview") as! WikipediaView
        self.navigationController?.pushViewController(storageVC, animated: true)
    }
}
extension WikipediaViewController :UISearchBarDelegate
{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Calling API
        if (search.text?.count)! >= 1 {
            doSearchCall()
        }else {
            errorLabel.isHidden = false
            errorLabel.text = "Please enter the string or character";
        }
        print("searchBarSearchButtonClicked")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    }
}
