//
//  Packages.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import Foundation

class Package : Codable, Equatable {
    
    let name: String
    let desc: String
    let subscriptionType: SubscriptionType
    let didUseBefore: Bool
    let benefits: [String]?
    let price: Double
    let tariff: Tariff
    let availableUntil: String
    var isFavorite: Bool? = false
    
    init(name: String, desc: String, subscriptionType: SubscriptionType, didUseBefore: Bool, benefits: [String]?, price: Double, tariff: Tariff, availableUntil: String, isFavorite: Bool? ) {
        self.name = name
        self.desc = desc
        self.subscriptionType = subscriptionType
        self.didUseBefore = didUseBefore
        self.benefits = benefits
        self.price = price
        self.tariff = tariff
        self.availableUntil = availableUntil
        self.isFavorite = isFavorite ?? false
    }
    
    enum SubscriptionType: String, Codable {
        case yearly
        case monthly
        case weekly
    }
    
    static func == (lhs: Package, rhs: Package) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.desc == rhs.desc &&
            lhs.subscriptionType == rhs.subscriptionType &&
            lhs.didUseBefore == rhs.didUseBefore &&
            lhs.benefits == rhs.benefits &&
            lhs.price == rhs.price &&
            lhs.tariff == rhs.tariff &&
            lhs.availableUntil == rhs.availableUntil &&
            lhs.isFavorite == rhs.isFavorite
    }

}
