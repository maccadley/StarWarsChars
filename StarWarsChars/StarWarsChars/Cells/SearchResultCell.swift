//
//  SearchResultCell.swift
//  StarWarsChars
//
//  Created by Admin on 15.02.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell{
    @IBOutlet weak var nameLabelText : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
