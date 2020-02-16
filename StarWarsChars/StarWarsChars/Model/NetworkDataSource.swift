//
//  NetworkDataSource.swift
//  StarWarsChars
//
//  Created by Admin on 16.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import Foundation

class NetworkDataSource: NetWork {
        let urlAccess = "https://swapi.co/api/people/?search="
        private var searchByName : SearchResult?
    
    func postRequest(name: String) {
        searchForCharacter(name: name)
    }
    
    func searchForCharacter(name:String){
        let searchUrl = urlAccess + name
        guard let url = URL(string: searchUrl) else {return}
        let accessUrlSession = URLSession.shared
        accessUrlSession.dataTask(with: url) { (data, responce, error) in
            if let error = error{
                print("Some problems with connection: \(error)")
                return
            }
        guard let data = data else {return}
        do {
            let searchReturn = try JSONDecoder().decode(SearchResult.self, from: data)
            print("search results object: \(searchReturn)")
            self.searchByName = searchReturn
        } catch let jsonError {
            print("Error has appeared \(jsonError)")
        }
    }.resume()
}
}
