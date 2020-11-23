//
//  PackagesViewController.swift
//  Package-Assignment
//
//  Created by Esra Dursun on 18/11/2020.
//

import UIKit
import DropDown

class PackagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dataButton: UIButton!
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    private var packagesVM = PackagesViewModel()
    
    let filterDropDown: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            FilterType.yearly.rawValue,
            FilterType.monthly.rawValue,
            FilterType.weekly.rawValue,
            FilterType.availableDate.rawValue
        ]
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: PackageCell.identifer, bundle: nil), forCellReuseIdentifier: PackageCell.identifer)
        
        dropDownSelectAction()
    }

    private func configureUI(){
        let dropDownView = UIView()
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dropDownView)
        
        dropDownView.bottomAnchor.constraint(equalTo: self.filterButton.bottomAnchor, constant: 0).isActive = true
        dropDownView.leftAnchor.constraint(equalTo: self.filterButton.leftAnchor, constant: 0).isActive = true
        filterDropDown.anchorView = dropDownView
        filterDropDown.width = 130
        configureButton(button: dataButton)
        configureButton(button: talkButton)
        configureButton(button: smsButton)
        configureButton(button: filterButton)
        enableSortButton(button: self.dataButton, dissable: true)
        searchBar.placeholder = "Type package name"
        self.tableView.estimatedRowHeight = 83.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func dropDownSelectAction(){
        filterDropDown.selectionAction = {index, title in
            self.packagesVM.packageList = self.packagesVM.getFilteredPackageListByFilterType(filterType: title)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func dataButton(sender: UIButton){
        didAndEnableButton(TariffType.data.rawValue)
    }
    
    @IBAction func talkButton(sender: UIButton){
        didAndEnableButton(TariffType.talk.rawValue)
    }
    
    @IBAction func smsButton(sender: UIButton){
        didAndEnableButton(TariffType.sms.rawValue)
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        filterDropDown.show()
    }
    

    private func configureButton(button : UIButton){
        button.layer.cornerRadius = 10
        button.frame.size = CGSize(width: 90, height: 30)
    }
    
    private func didAndEnableButton( _ sortedBy: String){
        switch sortedBy {
        case TariffType.sms.rawValue :
            enableSortButton(button: self.smsButton, dissable: true)
            
            enableSortButton(button: self.dataButton, dissable: false)
            enableSortButton(button: self.talkButton, dissable: false)
        case TariffType.talk.rawValue :
            enableSortButton(button: self.talkButton, dissable: true)
            
            enableSortButton(button: self.dataButton, dissable: false)
            enableSortButton(button: self.smsButton, dissable: false)
        default :
            enableSortButton(button: self.dataButton, dissable: true)
            
            enableSortButton(button: self.smsButton, dissable: false)
            enableSortButton(button: self.talkButton, dissable: false)
        }
        self.searchBar.text = ""
        self.packagesVM.selectedSorted = sortedBy
        self.packagesVM.getPackageList(sortedBy)
        self.tableView.reloadData()
    }
    
    private func enableSortButton(button: UIButton, dissable: Bool) {
        switch dissable {
        case true:
            button.isEnabled = false
            button.alpha = 0.3
        case false:
            button.isEnabled = true
            button.alpha = 1.0
        }
    }
    
    private func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension PackagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packagesVM.packageList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let package = self.packagesVM.packageList![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageCell.identifer, for: indexPath) as! PackageCell
        if package.didUseBefore {
            cell.didUseBefore.text = "Used Before"
        } else {
            cell.didUseBefore.text = "Didn't Use Before"
        }

        if package.isFavorite != nil{
            cell.isFavorite.text = "Favorite Package"
            cell.packageView.backgroundColor = UIColor.systemYellow
        } else {
            cell.isFavorite.text = "Not Favorite Package"
        }

        cell.name.text = "\(package.name)"
        cell.packDescription.text = "\(package.desc)"
        cell.price.text = "Price: \(package.price)"
        cell.subscriptionType.text = "Subscription Type: \(package.subscriptionType)"

        cell.data.text = "Data: \(package.tariff.data)"
        cell.talk.text = "Talk: \(package.tariff.talk)"
        cell.sms.text = "Sms: \(package.tariff.sms)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let package = self.packagesVM.packageList![indexPath.row]
        let alert = UIAlertController(title: "Do you want to add \(package.name) package to your favorite packages?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Favorite", style: .default) { (action) in
            self.packagesVM.addNewFavoritePackage(package: package)
            self.scrollToFirstRow()
            self.tableView.reloadData()
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in }))
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PackagesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.packagesVM.getPackageList(self.packagesVM.selectedSorted)
        
        self.packagesVM.packageList = searchText.isEmpty ? self.packagesVM.packageList! : self.packagesVM.packageList!.filter {(p: Package) -> Bool in
            return p.name.lowercased().contains(searchText.lowercased())
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    private func resetData() {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
    }
}
