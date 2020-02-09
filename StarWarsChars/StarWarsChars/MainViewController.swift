//
//  ViewController.swift
//  StarWarsChars
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var userSearchbar: UISearchBar!
    @IBOutlet weak var nameTextLabel: UILabel!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        request("https://swapi.co/api/people/1/").responseJSON { (response) in
            print(response)
        }
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Write Character's name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    

    
    @IBAction func searchButton(_ sender: Any) {
    }
}

extension MainViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController){
        
    }
}
