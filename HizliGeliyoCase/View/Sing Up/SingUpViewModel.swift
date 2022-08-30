//
//  SingUpViewModel.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 27.08.2022.
//

import Foundation
import UIKit
import FirebaseAuth

protocol SingUpViewModelProtocol {
    func setUpDelegate(_ viewController:SingUpViewController)
    func userSingUp(email : String, password : String,passwordAgain : String)
}

class SingUpViewModel : SingUpViewModelProtocol {
    var delegate: SingUpViewController?
    func setUpDelegate(_ viewController: SingUpViewController) {
        delegate = viewController
    }
    
    // MARK: - User Sing Up
    
    func userSingUp(email : String, password : String,passwordAgain : String) {
            Auth.auth().createUser(withEmail: email, password: password) { Authdata, error in
                if error != nil {
                    self.delegate?.alertMessageError(message:error!.localizedDescription)
                } else {
                    self.delegate?.alertMessageSuccess(title: "Tebrikler", message: "Başarılı bir şekilde kayıt oldunuz.Giriş ekranına yönlendirileceksiniz.")
                }
            }
        }
    }

