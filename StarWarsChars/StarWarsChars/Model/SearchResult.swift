//
//  SearchResult.swift
//  StarWarsChars
//
//  Created by Admin on 15.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import Foundation

struct SearchResult: Codable{
    var count: Int
    var next: String?
    var previous: String?
    var results: [CharacterPersonal]?
}

struct CharacterPersonal: Codable{
    var name : String
    var height : String
    var weight : String
    var hairColor : String
    var skinColor: String
    var eyeColor : String
    var birthYear : String
    var gender : String
}
