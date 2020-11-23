//
//  Tariff.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import Foundation

class Tariff: Codable, Equatable {
    
    let data: String
    let talk: String
    let sms: String
    
    init(data: String, talk: String, sms: String) {
        self.data = data
        self.talk = talk
        self.sms = sms
    }
    
    static func == (lhs: Tariff, rhs: Tariff) -> Bool {
        return
            lhs.data == rhs.data &&
            lhs.talk == rhs.talk &&
            lhs.sms == rhs.sms
    }
}
