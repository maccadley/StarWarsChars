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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request("https://swapi.co/api/people/1/").responseJSON { (response) in
            print(response)
        }
        
        
    }

    
    @IBAction func searchButton(_ sender: Any) {
    }
}

