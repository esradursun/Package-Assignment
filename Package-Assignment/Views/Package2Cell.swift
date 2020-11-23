//
//  Package2Cell.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 19/11/2020.
//

import UIKit

class Package2Cell: UICollectionViewCell {
    
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!
    @IBOutlet weak var column3: UILabel!
    @IBOutlet weak var column4: UILabel!
    @IBOutlet weak var column5: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.backgroundColor = .none
    }

}
