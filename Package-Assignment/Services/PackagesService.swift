//
//  PackageListService.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import Foundation

class PackagesService {
    
    public func parsePackageJSON(completionHandler: @escaping (PackageDictionary?) -> ()) {
        guard let path = Bundle.main.path(forResource: "packageList", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let packageList = try JSONDecoder().decode(PackageDictionary.self, from: data)
            completionHandler(packageList)
        } catch {
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
}
