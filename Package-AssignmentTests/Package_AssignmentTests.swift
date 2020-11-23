//
//  Package_AssignmentTests.swift
//  Package-AssignmentTests
//
//  Created by Esra Dursun on 18/11/2020.
//

import XCTest
@testable import Package_Assignment

class Package_AssignmentTests: XCTestCase {
    
    let packageList : [Package] = [
        Package(name:"Platinum Maksi 6 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: true, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 109.90, tariff: Tariff(data: "614", talk: "2000", sms: "1000"), availableUntil:"15581311050", isFavorite: false),
        Package(name:"Platinum Maksi 8 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: false, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 129.90, tariff: Tariff(data: "8192", talk: "200", sms: "100"), availableUntil:"1555060350", isFavorite: false),
        Package(name:"Platinum Maksi 12 GB", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "yearly")!, didUseBefore: false, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 109.90, tariff: Tariff(data: "12288", talk: "2000", sms: "100"), availableUntil:"1555060350", isFavorite: false),
        Package(name:"Akıllı 2 GB Paket", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "yearly")!, didUseBefore: true, benefits: [  "lifebox","BiP","Dergilik"], price: 54.69, tariff: Tariff(data: "2048", talk: "500", sms: "1000"), availableUntil:"1553253117", isFavorite: false),
        Package(name:"Akıllı Fatura Ek İnternet Paketi", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "weekly")!, didUseBefore: false, benefits: [  "lifebox","BiP","Dergilik"], price: 19, tariff: Tariff(data: "1024", talk: "0", sms: "100"), availableUntil:"1563758610", isFavorite: false),
        Package(name:"Akıllı Fatura 250 Dakika Paketi", desc:"desc", subscriptionType:Package.SubscriptionType(rawValue: "weekly")!, didUseBefore: false, benefits: [  "lifebox","BiP"], price: 19, tariff: Tariff(data: "0", talk: "250", sms: "0"), availableUntil:"1563758610", isFavorite: false)
    ]
    
    let favoriteList : [Package] = [
        Package(name:"Platinum Maksi 6 GB", desc:"Zengin içerikli Platinum Maksi Paketi ile Turkcell Uygulamalarının keyfini sürün!", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: true, benefits: [  "TV+","Fizy","BiP","lifebox","Platinum","Dergilik"], price: 109.90, tariff: Tariff(data: "614", talk: "200", sms: "100"), availableUntil:"15581311050", isFavorite: true),
        Package(name:"Akıllı Fatura 250 Dakika Paketi", desc:"Akıllı Fatura Kampanyası ile paket bitiminden sonra Akıllı Fatura Ek Paketi alarak kullanıma devam edebilirsiniz.", subscriptionType:Package.SubscriptionType(rawValue: "monthly")!, didUseBefore: false, benefits: [  "lifebox","BiP"], price: 19, tariff: Tariff(data: "0", talk: "250", sms: "1000"), availableUntil:"1563758610", isFavorite: true)
    ]
    
    let packagesServiceMock = PackagesServiceMock()
    var packagesVM: PackagesViewModel = PackagesViewModel()

    override func setUp() {
        packagesVM = PackagesViewModel(packageService: packagesServiceMock, favoriteService: FavoriteService(fileName: "testFavoritePackages.plist"))

        packagesServiceMock.parsePackageJSON(completionHandler: { (packages) in
            if let packages = packages {
                self.packagesVM.jsonPackageList = packages.packages
            }
        })
    }
    
    func testGetFilteredPackageListCalledAndFavoriteListIsEmpty_shouldReturnSortedPackageListBySubscriptionTypeAndDataTariffAsDefault() {
        packagesVM.favoritePackages = []
        packagesVM.getPackageList()
        
        XCTAssertEqual(packagesVM.packageList?[0], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[2], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[0].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledAndFavoriteListIsEmptyWithDataSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndDataTariffAsDefault() {
        packagesVM.favoritePackages = []
        packagesVM.getPackageList("data")
        
        XCTAssertEqual(packagesVM.packageList?[0], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[2], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[0].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledAndFavoriteListIsEmptyWithSmsSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndSmsTariff() {
        packagesVM.favoritePackages = []
        packagesVM.getPackageList("sms")
        
        XCTAssertEqual(packagesVM.packageList?[0], packageList[3])
        XCTAssertEqual(packagesVM.packageList?[2], packageList[0])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[0].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledAndFavoriteListIsEmptyWithTalkSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndTalkTariff() {
        packagesVM.favoritePackages = []
        packagesVM.getPackageList("talk")
        
        XCTAssertEqual(packagesVM.packageList?[0], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[2], packageList[0])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[5])
        
        XCTAssertEqual(packagesVM.packageList?[0].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalled_shouldReturnSortedPackageListBySubscriptionTypeAndDataTariffAsDefault() {
        packagesVM.favoritePackages = favoriteList
        packagesVM.getPackageList()
        
        
        XCTAssertEqual(packagesVM.packageList?[0], favoriteList[0])
        XCTAssertEqual(packagesVM.packageList?[1], favoriteList[1])
        
        XCTAssertEqual(packagesVM.packageList?[2], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[5], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[5].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledWithDataSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndDataTariffAsDefault() {
        packagesVM.favoritePackages = favoriteList
        packagesVM.getPackageList("data")
        
        
        XCTAssertEqual(packagesVM.packageList?[0], favoriteList[0])
        XCTAssertEqual(packagesVM.packageList?[1], favoriteList[1])
        
        XCTAssertEqual(packagesVM.packageList?[2], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[5], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[5].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledWithSmsSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndSmsTariff() {
        packagesVM.favoritePackages = favoriteList
        packagesVM.getPackageList("sms")
        
        
        XCTAssertEqual(packagesVM.packageList?[0], favoriteList[1])
        XCTAssertEqual(packagesVM.packageList?[1], favoriteList[0])
        
        XCTAssertEqual(packagesVM.packageList?[2], packageList[3])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[5], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[5].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListCalledWithTalkSortParameter_shouldReturnSortedPackageListBySubscriptionTypeAndTalkTariff() {
        packagesVM.favoritePackages = favoriteList
        packagesVM.getPackageList("talk")
        
        
        XCTAssertEqual(packagesVM.packageList?[0], favoriteList[1])
        XCTAssertEqual(packagesVM.packageList?[1], favoriteList[0])
        
        XCTAssertEqual(packagesVM.packageList?[2], packageList[2])
        XCTAssertEqual(packagesVM.packageList?[4], packageList[1])
        XCTAssertEqual(packagesVM.packageList?[5], packageList[4])
        
        XCTAssertEqual(packagesVM.packageList?[2].subscriptionType.rawValue, "yearly")
        XCTAssertEqual(packagesVM.packageList?[4].subscriptionType.rawValue, "monthly")
        XCTAssertEqual(packagesVM.packageList?[5].subscriptionType.rawValue, "weekly")
    }
    
    func testGetFilteredPackageListByFilterTypeYearlyParameter_shouldReturnFilteredPackageListBySubscriptionYearlyType() {
        packagesVM.getPackageList()
        let filteredPackageListBySelectedItem = packagesVM.getFilteredPackageListByFilterType(filterType: "yearly")
        
        XCTAssertEqual(filteredPackageListBySelectedItem[0], packageList[2])
        XCTAssertEqual(filteredPackageListBySelectedItem[1], packageList[3])
        XCTAssertEqual(filteredPackageListBySelectedItem.count, 2)
    }
    
    func testGetFilteredPackageListByFilterTypeWithWeeklyParameter_shouldReturnFilteredPackageListBySubscriptionWeeklyType() {
        packagesVM.getPackageList()
        let filteredPackageListBySelectedItem = packagesVM.getFilteredPackageListByFilterType(filterType: "weekly")
        
        XCTAssertEqual(filteredPackageListBySelectedItem[0], packageList[4])
        XCTAssertEqual(filteredPackageListBySelectedItem[1], packageList[5])
        XCTAssertEqual(filteredPackageListBySelectedItem.count, 2)
    }
    
    func testGetFilteredPackageListByFilterTypeWithAvailableUntilParameter_shouldReturnFilteredPackageListByAvailableUntilParameter() {
        packagesVM.getPackageList()
        let filteredPackageListBySelectedItem = packagesVM.getFilteredPackageListByFilterType(filterType: "availableDate")
        
        XCTAssertEqual(filteredPackageListBySelectedItem[0], packageList[0])
        XCTAssertEqual(filteredPackageListBySelectedItem.count, 1)
    }
    
}
