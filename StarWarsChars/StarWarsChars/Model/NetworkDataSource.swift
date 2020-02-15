//
//  NetworkDataSource.swift
//  StarWarsChars
//
//  Created by Admin on 16.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import Foundation

class NetworkDataSource {
        let urlAccess = "https://swapi.co/api/people/?search=r"
        let test = "https://swapi.co/api/people/1/"
        private var searchByName : SearchResult?
    
    func searchForCharacter(name:String){
            let searchUrl = urlAccess + name
        guard let url = URL(string: searchUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
        guard let data = data else {return}
        do {
            let searchReturn = try JSONDecoder().decode(SearchResult.self, from: data)
            print(searchReturn)
            self.searchByName = searchReturn
        } catch let jsonError {
            print("Error has appeared \(jsonError)")
        }
    }.resume()
}
}
