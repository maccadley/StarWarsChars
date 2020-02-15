//
//  ViewController.swift
//  StarWarsChars
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    private var searchResults = [SearchResult]()
    var searchToDisplay: [String] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var nameRequested : SearchResult?{
        didSet{
            parceJson()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Write Character's name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tapToDismiss.cancelsTouchesInView = false
        view.addGestureRecognizer(tapToDismiss)
    }
    
    @objc func dissmissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    private func parceJson(){
        var parceResults: [String] = []
        if let results = nameRequested?.results{
            for items in results {
                parceResults.append(items.name)
            }
            searchToDisplay.append(contentsOf: parceResults)
            tableView.reloadData()
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell{
            cell.nameLabelText.text = searchToDisplay[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MainViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController){
        
    }
    func filteredContent(searchText: String){
      //  searchResult = recievedData.filter(...)
    }
}
