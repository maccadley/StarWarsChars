//
//  ViewController.swift
//  StarWarsChars
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarInput: UISearchBar!

    private var searchResults = [SearchResult]()
    var emptyData : [String] = []
    var searchToDisplay: [String] = []
    var nameRequested : SearchResult?{
        didSet{
            parceJson()
        }
    }
    var searchDelayTimer: Timer?
    var netAccess : NetWork?
    let network = NetworkDataSource()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchToDisplay = emptyData
        netAccess = network
        searchBarInput.delegate = self
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
                print(parceResults)
            }
            searchToDisplay.append(contentsOf: parceResults)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func displayResults(charName: String) -> [CharacterPersonal]?{
        var searchResult : [CharacterPersonal]?
        if let nameCharecter = nameRequested{
            guard let personName = nameCharecter.results else { return nil }
            searchResult = personName.filter({
                $0.name == charName
            })
        }; return searchResult
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchToDisplay.count
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Searched through Star Wars"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultCell{
            cell.nameLabelText.text = searchToDisplay[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}


extension MainViewController{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelayTimer?.invalidate()
        searchDelayTimer = nil
        searchDelayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.searchDelay), userInfo: searchText, repeats: false)
        searchToDisplay = searchText.isEmpty ? emptyData : emptyData.filter({ (stringResult: String) -> Bool in
            return stringResult.range(of: searchText, options: .caseInsensitive) != nil
        })
        parceJson()
    }
    
    @objc func searchDelay(timer: Timer){
        guard let userInfo = searchDelayTimer?.userInfo as? String else {return}
        if userInfo != ""{
            netAccess?.postRequest(name: userInfo)
        } else {
            searchToDisplay = emptyData
            tableView.reloadData()
        }
        searchDelayTimer = nil
    }
}
