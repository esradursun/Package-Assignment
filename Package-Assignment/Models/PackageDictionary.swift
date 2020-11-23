//
//  PackageDictionary.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import Foundation

class PackageDictionary : Codable {
    var packages = [Package]()
    
    init(packages: [Package]){
        self.packages = packages
    }
}
