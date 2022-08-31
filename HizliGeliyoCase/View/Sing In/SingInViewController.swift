//
//  ViewController.swift
//  HizliGeliyoCase
//
//  Created by İSMAİL AÇIKYÜREK on 26.08.2022.
//

import UIKit
import FirebaseAuth

class SingInViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var securety = true
    let viewModel : SingInViewModelProtocol = SingInViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel.setUpDelegate(self)
        textFieldProperties()
        keyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.initialize()
    }
    
    // MARK: - Keyboard Hidden
    func keyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(keyboardClose))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func keyboardClose() {
        view.endEditing(true)
    }
    

    func textFieldProperties() {
        //cornerRadius
        txtEmail.layer.cornerRadius = txtEmail.frame.size.height/2
        txtPassword.layer.cornerRadius = txtPassword.frame.size.height/2
        
        //shadow
        txtEmail.layer.shadowOpacity=0.2
        txtEmail.layer.shadowOffset = CGSize(width: 0, height: 2)
        txtPassword.layer.shadowOpacity=0.2
        txtPassword.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        txtEmail.layer.masksToBounds = true
        txtEmail.clipsToBounds = false
        txtPassword.layer.masksToBounds = true
        txtPassword.clipsToBounds = false
    }
    // MARK: - Password Securety
    @IBAction func showHidden(_ sender: Any) {
        if securety == true {
            txtPassword.isSecureTextEntry = false
            securety = false
        } else {
            txtPassword.isSecureTextEntry = true
            securety = true
        }
    }
    // MARK: - Sing In
    @IBAction func singInClick(_ sender: Any) {
        guard let email = txtEmail.text else {return}
        guard let password = txtPassword.text else {return}
        
        if email == "" || password == "" {
            alertMessageError(message: "Email veya şifre alanı boş.")
        } else {
            viewModel.userLogin(email: email, password: password)
        }
    }
    
    func alertMessageError(message : String) {
        let Alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(OK)
        present(Alert, animated: true, completion: nil)
    }
    
    func nextHomeVc() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home")
        present(nextViewController, animated: true)
    }
}
