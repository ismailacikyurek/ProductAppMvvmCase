//
//  CategoryViewModel.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import UIKit

protocol CategoryViewModelProtocol {
    var categoryName : [String] {get set}
    func initialize()
    func setUpDelegate(_ viewController: CategoryViewController)
    func cellCategoryNameLocalization(data : String,cell : UITableViewCell)
    func alertMessageError(message : String)
}

class CategoryViewModel:NSObject {
    var categoryName = [String]()
    private let service: ProductServiceProtocol = ProductsDataService()
    private let serviceManager = ServiceManager()
    var delegate: CategoryViewController?
    
    func initialize() {
        categoryDataService()
    }
    func categoryDataService() {
        service.fethAllPosts(url:serviceManager.url) { [weak self] model in
            self?.categoryNameList(content: model)
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    
    func categoryNameList(content : [ProductsModel]) {
        for i in 0...(content.count-1) {
            guard let name = content[i].category else {return}
            if categoryName.contains(name.rawValue) {
            } else {
                categoryName.append(name.rawValue)
                delegate?.tableView.reloadData()    
            }
        }
    }
    // MARK: - Turkish Translate
    func cellCategoryNameLocalization(data : String, cell : UITableViewCell) {
        switch data {
        case "electronics" : cell.textLabel?.text = "Elektronik"
        case "jewelery" : cell.textLabel?.text = "Mücevher"
        case "men's clothing" : cell.textLabel?.text = "Erkek Kıyafeti"
        default : cell.textLabel?.text = "Kadın Kıyafeti"
        }
    }
    
    func alertMessageError(message : String) {
        let Alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(OK)
        delegate?.present(Alert, animated: true, completion: nil)
    }
}

extension CategoryViewModel: CategoryViewModelProtocol {
    func setUpDelegate(_ viewController: CategoryViewController) {
        delegate = viewController
    }
}
