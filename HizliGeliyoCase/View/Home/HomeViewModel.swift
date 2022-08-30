//
//  HomeViewModel.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//
import UIKit

protocol HomeViewModelProtocol {
    var filterArray : [ProductsModel]? { get set }
     var modelProduct : [ProductsModel]? { get set }
    func initialize()
    func setUpDelegate(_ viewController: HomeViewController)
    func search(searctext: String, model : [ProductsModel]) -> [ProductsModel]
    func categoryFiltre(category: String, model : [ProductsModel]) -> [ProductsModel]
}

protocol HomeViewModelOutputProtocol {
    func showData(content: [ProductsModel])
}

class HomeViewModel:NSObject,HomeViewModelProtocol{
    var modelProduct: [ProductsModel]?
    var filterArray : [ProductsModel]?
    private let service: ProductServiceProtocol = ProductsDataService()
    private let serviceManager = ServiceManager()
    var delegate: HomeViewModelOutputProtocol?
    
    func initialize() {
        ProductDataService()
    }
    
    func setUpDelegate(_ viewController: HomeViewController) {
        delegate = viewController
    }
    
    func ProductDataService() {
        service.fethAllPosts(url:serviceManager.url) { [weak self] model in
            self?.delegate?.showData(content: model)
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    // MARK: - Filters
    func search(searctext: String, model: [ProductsModel]) -> [ProductsModel] {
        let filterTitleArray = searctext.isEmpty ? model : model.filter {$0.title?.lowercased().contains(searctext.lowercased()) as! Bool}
        let filterCategoryArray = searctext.isEmpty ? model : model.filter {$0.category?.rawValue.contains(searctext.lowercased()) as! Bool}
        filterArray = filterCategoryArray + filterTitleArray
        guard let filterArray = filterArray else { return [ProductsModel.init()]}
        return filterArray
    }
    
    func categoryFiltre(category: String, model : [ProductsModel]) -> [ProductsModel] {
        filterArray = model.filter {$0.category?.rawValue.elementsEqual(category) as! Bool}
        guard let filterArray = filterArray else { return [ProductsModel.init()]}
        return filterArray
    }
}



