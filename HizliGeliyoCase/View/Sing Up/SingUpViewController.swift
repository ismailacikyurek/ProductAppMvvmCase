//
//  SingUpViewController.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 26.08.2022.
//

import UIKit
import FirebaseAuth

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswordAgain: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var securetyFirst = true
    var securetySecond = true
    let viewModel : SingUpViewModelProtocol = SingUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        textFieldPropertiesLoad()
        keyboard()
    }
    // MARK: - Keyboard Hidden
    func keyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(keyboardClose))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func keyboardClose() {
        view.endEditing(true)
    }
    
    func textFieldPropertiesLoad() {
        //cornerRadius
        txtEmail.layer.cornerRadius = txtEmail.frame.size.height/2
        txtPassword.layer.cornerRadius = txtPassword.frame.size.height/2
        txtPasswordAgain.layer.cornerRadius = txtPassword.frame.size.height/2
        
        //shadow
        txtEmail.layer.shadowOpacity=0.2
        txtEmail.layer.shadowOffset = CGSize(width: 0, height: 2)
        txtPassword.layer.shadowOpacity=0.2
        txtPassword.layer.shadowOffset = CGSize(width: 0, height: 4)
        txtPasswordAgain.layer.shadowOpacity=0.2
        txtPasswordAgain.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        txtEmail.layer.masksToBounds = true
        txtEmail.clipsToBounds = false
        txtPassword.layer.masksToBounds = true
        txtPassword.clipsToBounds = false
        txtPasswordAgain.layer.masksToBounds = true
        txtPasswordAgain.clipsToBounds = false
    }
    // MARK: - Sing Up
    
    @IBAction func btnSingUpClick(_ sender: Any) {
        guard let email = txtEmail.text else {return}
        guard let password = txtPassword.text else {return}
        guard let passwordAgain = txtPasswordAgain.text else {return}

        if email == "" {alertMessageError(message: "E-mailiniz boş.")}
        if password == "" || passwordAgain == "" {alertMessageError(message: "Şifre alanları boş.")}
        if password != passwordAgain {alertMessageError(message: "Şifreler uyuşmuyor.")}
        if password.count < 6 {alertMessageError(message: "Şifreniz en az 6 karakterden oluşması gerekiyor.")}
        
        else {
            viewModel.userSingUp(email: email, password: password, passwordAgain: passwordAgain)
        }
    }
    
    func alertMessageError(message : String) {
        let Alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(OK)
        present(Alert, animated: true, completion: nil)
    }
    
    func alertMessageSuccess(title : String, message : String) {
        let Alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { alert in
        self.navigationController?.popViewController(animated: true)
        }
        Alert.addAction(OK)
        present(Alert, animated: true, completion: nil)
    }
    
    // MARK: - Password Securety
    
    @IBAction func btnShowHiddenPassword(_ sender: Any) {
        if securetyFirst == true {
            txtPassword.isSecureTextEntry = false
            securetyFirst = false
        } else {
            txtPassword.isSecureTextEntry = true
            securetyFirst = true
        }
    }
    
    @IBAction func btnShowHiddenAgainPassword(_ sender: Any) {
        if securetySecond == true {
            txtPasswordAgain.isSecureTextEntry = false
            securetySecond = false
        } else {
            txtPasswordAgain.isSecureTextEntry = true
            securetySecond = true
        }
    }
}
