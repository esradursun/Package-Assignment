//
//  PackagesViewModel.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import Foundation
import UIKit

class PackagesViewModel {
    
    private var packageService: PackagesService
    private var favoriteService: FavoriteService

    var jsonPackageList:[Package]?
    var favoritePackages: [Package]?
    var packageList:[Package]?
    var filteredPackageList:[Package]?
    var selectedSorted: String = TariffType.data.rawValue
   
    var count : Int {
        guard let filteredPackages = packageList else { return 0 }
        return filteredPackages.count
    }
   
    init(packageService: PackagesService = PackagesService(), favoriteService : FavoriteService = FavoriteService()) {
        self.packageService = packageService
        self.favoriteService = favoriteService
        
        fetchPackageJSON()
        favoritePackages = self.favoriteService.loadFavoritePackages()
        getPackageList()
    }

    public func getPackageList(_ sortedBy: String = TariffType.data.rawValue){
        guard let favoritePackageList = favoritePackages else {return }
        packageList = [getSortedPackagesBySubscriptionTypeAndData(favoritePackageList, sortedBy),  getSortedPackagesBySubscriptionTypeAndData(filterPackagesByFavorites(), sortedBy)].reduce([],{
            return $0 + $1
        })
        self.filteredPackageList = self.packageList
    }
  
    public func addNewFavoritePackage(package: Package){
        favoriteService.addNewFavoritePackage(package: package)
        self.favoritePackages = favoriteService.loadFavoritePackages()
        self.getPackageList()
    }
    
    public func getFilteredPackageListByFilterType(filterType: String) -> [Package]{
        guard let selectedFilteredList = filteredPackageList else {return []}

        switch filterType {
        case FilterType.yearly.rawValue:
           return selectedFilteredList.filter{ $0.subscriptionType.rawValue.contains(filterType) }
        case FilterType.monthly.rawValue:
            return selectedFilteredList.filter{ $0.subscriptionType.rawValue.contains(filterType) }
        case FilterType.weekly.rawValue:
            return selectedFilteredList.filter{ $0.subscriptionType.rawValue.contains(filterType) }
        case FilterType.availableDate.rawValue:
            return selectedFilteredList.filter{ Double($0.availableUntil)! > NSDate().timeIntervalSince1970 }
        default:
            return selectedFilteredList
        }
    }

    private func fetchPackageJSON() {
        self.packageService.parsePackageJSON { (packages) in
            if let packages = packages {
                self.jsonPackageList = packages.packages
            }
        }
    }
    
    private func filterPackagesByFavorites() -> [Package]{
        guard let favoritePackageList = favoritePackages else {return []}
        guard let packages = jsonPackageList else {return []}
        return packages.filter{
            !favoritePackageList.map({$0.name}).contains($0.name)
        }
    }
    
    private func getSortedPackagesBySubscriptionTypeAndData(_ packageList: [Package], _ sortedBy: String) -> [Package] {
        let dictionary = Dictionary(grouping: packageList, by: {
            return $0.subscriptionType
        })
       
        return getSortedTariff(dictionary[Package.SubscriptionType.yearly] ?? [Package](), sortedBy)
            + getSortedTariff(dictionary[Package.SubscriptionType.monthly] ?? [Package](), sortedBy)
            + getSortedTariff(dictionary[Package.SubscriptionType.weekly] ?? [Package](), sortedBy)
    }
    
    private func getSortedTariff(_ packageList: [Package], _ sortedBy: String) -> [Package] {
        return packageList.sorted {
            switch sortedBy {
            case TariffType.sms.rawValue :
                return Int($0.tariff.sms) ?? 0 > Int($1.tariff.sms) ?? 0
            case TariffType.talk.rawValue :
                return Int($0.tariff.talk) ?? 0 > Int($1.tariff.talk) ?? 0
            default :
                return Int($0.tariff.data) ?? 0 > Int($1.tariff.data) ?? 0
            }
        }
    }
    
}
