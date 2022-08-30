//
//  CategoryViewController.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFiltre: UIButton!
    let viewModel : CategoryViewModelProtocol = CategoryViewModel()
    var selectedCategory : String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        viewModel.initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeVC" {
            let nextVC = segue.destination as? HomeViewController
            nextVC?.categoryTofilterName = selectedCategory
        }
    }
    
    @IBAction func btnExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFiltreClick(_ sender: Any) {
        if selectedCategory != nil {
          performSegue(withIdentifier: "goToHomeVC", sender: nil)
        } else {
            viewModel.alertMessageError(message: "Lütfen bir kategori seçin. Kategori seçmek istemiyorsanız sol üstteki butona tıklayarak geri dönebilirsiniz.")
        }
    }
}
// MARK: - Tableview
extension CategoryViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categoryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! CategoryTableViewCell
        viewModel.cellCategoryNameLocalization(data: viewModel.categoryName[indexPath.row], cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = viewModel.categoryName[indexPath.row]
    }
}
