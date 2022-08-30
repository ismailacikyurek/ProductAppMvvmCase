//
//  ProfileViewModel.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

//
import Foundation
import UIKit
import FirebaseAuth

protocol ProfileViewModelProtocol {
    func setUpDelegate(_ viewController: ProfileViewController)
    func logOut()
}

class ProfileViewModel : ProfileViewModelProtocol {
    var delegate: ProfileViewController?
    func setUpDelegate(_ viewController: ProfileViewController) {
        delegate = viewController
    }
    // MARK: - LOG OUT
    func logOut() {
        do {
            try Auth.auth().signOut()
            delegate?.nextSingInVc()
        } catch {
            print(error)
        }
    }
}
