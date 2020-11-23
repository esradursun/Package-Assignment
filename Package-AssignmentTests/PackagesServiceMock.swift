//
//  PackagesServiceMock.swift
//  Package-AssignmentTests
//
//  Created by Esra Dursun on 21/11/2020.
//

import XCTest
@testable import Package_Assignment

class PackagesServiceMock: PackagesService {
    
    let packageDictionary = PackageDictionary(packages: [
        Package(name:"Platinum Maksi 6 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: true, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 109.90, tariff: Tariff(data: "614", talk: "2000", sms: "1000"), availableUntil:"15581311050", isFavorite: false),
        Package(name:"Platinum Maksi 8 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: false, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 129.90, tariff: Tariff(data: "8192", talk: "200", sms: "100"), availableUntil:"1555060350", isFavorite: false),
        Package(name:"Platinum Maksi 12 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "yearly")!, didUseBefore: false, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 109.90, tariff: Tariff(data: "12288", talk: "2000", sms: "100"), availableUntil:"1555060350", isFavorite: false),
        Package(name:"Akıllı 2 GB Paket", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "yearly")!, didUseBefore: true, benefits: [  "lifebox","BiP","Dergilik"], price: 54.69, tariff: Tariff(data: "2048", talk: "500", sms: "1000"), availableUntil:"1553253117", isFavorite: false),
        Package(name:"Akıllı Fatura Ek İnternet Paketi", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "weekly")!, didUseBefore: false, benefits: [  "lifebox","BiP","Dergilik"], price: 19, tariff: Tariff(data: "1024", talk: "0", sms: "100"), availableUntil:"1563758610", isFavorite: false),
        Package(name:"Akıllı Fatura 250 Dakika Paketi", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "weekly")!, didUseBefore: false, benefits: [  "lifebox","BiP"], price: 19, tariff: Tariff(data: "0", talk: "250", sms: "0"), availableUntil:"1563758610", isFavorite: false)
    ])

    override func parsePackageJSON(completionHandler: @escaping (PackageDictionary?) -> ()) {
        completionHandler(packageDictionary)
    }

}



