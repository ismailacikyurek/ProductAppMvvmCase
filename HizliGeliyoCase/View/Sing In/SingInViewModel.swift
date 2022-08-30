//
//  SingInViewModel.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//
import Foundation
import FirebaseAuth

protocol SingInViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: SingInViewController)
    func userLogin(email: String, password: String)
}

class SingInViewModel : SingInViewModelProtocol {
    var delegate: SingInViewController?
    
    func setUpDelegate(_ viewController: SingInViewController) {
        delegate = viewController
    }
    
    func initialize() {
        currentControl()
    }
    
    func currentControl() {
        let currentUSer = Auth.auth().currentUser
        if currentUSer != nil {
            delegate?.nextHomeVc()
        }
    }
    
    
    func userLogin(email : String, password : String){
          Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.delegate?.alertMessageError(message:error!.localizedDescription)
            } else {
                self.delegate?.nextHomeVc()
            }
        }
    }
}
