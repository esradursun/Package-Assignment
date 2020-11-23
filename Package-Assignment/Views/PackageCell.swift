//
//  PackageCell2.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 19/11/2020.
//

import UIKit

class PackageCell: UITableViewCell {

    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var packDescription: UILabel!
    @IBOutlet weak var subscriptionType: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var talk: UILabel!
    @IBOutlet weak var sms: UILabel!
    @IBOutlet weak var didUseBefore: UILabel!
    @IBOutlet weak var isFavorite: UILabel!
    
    static let identifer = "PackageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.backgroundColor = .none
        self.packageView.backgroundColor = .none
    }
    
}
