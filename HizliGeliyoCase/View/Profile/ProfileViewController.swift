//
//  LogOutViewController.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    let viewModel : ProfileViewModelProtocol = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
    }
    
    @IBAction func bntLogOutClicked(_ sender: Any) {
        viewModel.logOut()
    }
    
    func nextSingInVc() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewControllerr = storyBoard.instantiateViewController(withIdentifier: "singIn")
        present(nextViewControllerr, animated: true)
    }
}
