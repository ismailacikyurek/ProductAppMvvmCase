//
//  HomeViewController.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
   
    @IBOutlet weak var btnFiltre: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ViewButtons: UIView!
    @IBOutlet weak var btnSirala: UIButton!
    var viewModel : HomeViewModelProtocol = HomeViewModel() 
    var categoryTofilterName : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        }
 
    override func viewDidAppear(_ animated: Bool) {
        self.filtreCategory()
    }

    func setupUI() {
        viewModel.setUpDelegate(self)
        viewModel.initialize()
        searchBarProperties()
        viewButtonsProperties()
        collectionViewDesing()
    }
    // MARK: - Desing Functions
    func searchBarProperties() {
        searchBar.layer.cornerRadius = searchBar.frame.size.height/2
        searchBar.searchTextField.borderStyle = .none
        searchBar.layer.shadowOpacity = 0.1
        searchBar.layer.shadowOffset = CGSize(width: 1, height: 0)
        searchBar.layer.borderWidth = 0
        searchBar.delegate = self
        searchBar.layer.masksToBounds = true
        searchBar.clipsToBounds = false
    }
    
    func viewButtonsProperties() {
        ViewButtons.layer.cornerRadius = 22
        ViewButtons.layer.shadowOpacity = 0.1
        ViewButtons.layer.shadowOffset = CGSize(width: 1, height: 0)
    }
    
    func collectionViewDesing() {
        let desing : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let widthScree = self.collectionView.frame.size.width
        desing.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        desing.itemSize = CGSize(width: (widthScree-80)/2, height: (widthScree-150))
        desing.minimumLineSpacing = 10
        desing.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = desing
    }
    // MARK: - Filtre Category
    func filtreCategory() {
        guard let categoryTofilterName = categoryTofilterName else {return}
        guard let ModelProduct = viewModel.modelProduct else {return}
        viewModel.filterArray = viewModel.categoryFiltre(category: categoryTofilterName, model: ModelProduct)
        btnFiltre.isEnabled = false
        collectionView.reloadData()
        }
}

extension HomeViewController : UISearchBarDelegate {
    // MARK: - Filtre Category and Filtre Product Name
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let ModelProduct =  viewModel.modelProduct else {return}
        viewModel.filterArray = viewModel.search(searctext: searchText, model: ModelProduct)
        collectionView.reloadData()
    }
}

extension HomeViewController : HomeViewModelOutputProtocol {
    func showData(content: [ProductsModel]) {
        viewModel.modelProduct = content
        viewModel.filterArray =  viewModel.modelProduct
        collectionView.reloadData()
    }
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.filterArray?.count else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        guard let product = viewModel.filterArray?[indexPath.item] else {return cell}
        cell.configure(content: product)
        cell.roundCornerss(corners: [.topRight,.topLeft], radius: 30)
        return cell
    }
}

