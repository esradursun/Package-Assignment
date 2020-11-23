//
//  FavoriteService.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 21/11/2020.
//

import Foundation

class FavoriteService {
    
    var dataFilePath: URL
    private static let FAVORITE_PACKAGE = "favoritePackage.plist"
    
    init(fileName: String = FAVORITE_PACKAGE){
        self.dataFilePath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName))!
    }
    
    public func storeFavoritePackage(_ packageList: [Package]){
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(packageList)
            try data.write(to: self.dataFilePath)
        } catch{
            print("Unable to Encode Favorite Package (\(error))")
        }
    }
    
    public func loadFavoritePackages() -> [Package] {
        var loadFavoritePacages = [Package]()
        if let data = try? Data(contentsOf: self.dataFilePath){
            let decoder = PropertyListDecoder()
            do {
                loadFavoritePacages = try decoder.decode([Package].self, from: data)
            } catch {
                print("Unable to Decode Favorite Package (\(error))")
            }
        }
        return loadFavoritePacages
    }
    
    public func addNewFavoritePackage(package: Package){
        var packageList: [Package] = self.loadFavoritePackages()
        if(!packageList.map({ $0.name }).contains(package.name)){
            package.isFavorite = true
            packageList.append(package)
            self.storeFavoritePackage(packageList)
        }
    }
    
}
