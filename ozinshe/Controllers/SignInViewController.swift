//
//  SignInViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 24.10.2024.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {
    
        let welcomeLabel = {
            let label = UILabel()
            label.text = "Сәлем"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
            label.textColor = UIColor(named: "111827 - FFFFFF")
            
            return label
        }()
        
        let signInLabel = {
            let label = UILabel()
            label.text = "Аккаунтқа кіріңіз"
            label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
            
            return label
        }()
        
        let emailLabel = {
            let label = UILabel()
            label.text = "Email"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
            label.textColor = UIColor(named: "111827 - FFFFFF")
            
            return label
        }()
        
        let emailTextField = {
            let tf = TextFieldWithPadding()
            tf.placeholder = "Сіздің email"
            tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            tf.textColor = UIColor(named: "111827 - FFFFFF")
            tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
            tf.layer.cornerRadius = 12
            tf.layer.borderWidth = 1
            
           return tf
        }()
        
        let emailImage = {
            let iv = UIImageView()
            iv.image = UIImage(named: "email")
            
            return iv
        }()
    
        let passwordLabel = {
            let label = UILabel()
            label.text = "Құпиясөз"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
            label.textColor = UIColor(named: "111827 - FFFFFF")
            
            return label
        }()
        
        let passwordTextField = {
            let tf = TextFieldWithPadding()
            tf.placeholder = "Сіздің құпия сөзіңіз"
            tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            tf.textColor = UIColor(named: "111827 - FFFFFF")
            tf.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
            tf.isSecureTextEntry = true
            tf.layer.cornerRadius = 12
            tf.layer.borderWidth = 1
            
           return tf
        }()

        let passwordImage = {
            let iv = UIImageView()
            iv.image = UIImage(named: "password")
            
            return iv
        }()
        
    lazy var showPasswordButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "showPassword"), for: .normal)
            button.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
            
            return button
        }()
        
    lazy var signInButton = {
            let button = UIButton()
            button.setTitle("Кіру", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
            button.backgroundColor = UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00)
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
            
            return button
        }()
        
    lazy var signUpButton = {
            let button = UIButton()
            button.setTitle("Тіркелу", for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            button.setTitleColor(UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00), for: .normal)
            button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
            
            return button
        }()
    
        let questionLabel = {
            let label = UILabel()
            label.text = "Аккаунтыңыз жоқ па?"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
            label.textAlignment = .right
            
            return label
        }()
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupUI()
        hideKeyboardWhenTappedAround()
        localizedLanguage()
    }
    
    //MARK: - Add functional
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signUpTapped() {
        let signUpViewController = SignUpViewController()
        
        navigationController?.show(signUpViewController, sender: self)
        navigationItem.title = ""
    }
    
    @objc func signInTapped() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        SVProgressHUD.show()
        
        let parameters = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                    if let sCode = response.response?.statusCode {
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func startApp() {
        let tabBarViewController = TabBarController()
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true, completion: nil)
    }
    
    @objc func showPasswordTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
       
    //MARK: - Add Subviews & Constraints
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubviews(welcomeLabel, signInLabel, emailLabel, emailTextField, emailImage, passwordLabel, passwordTextField, passwordImage, showPasswordButton, signInButton, signUpButton, questionLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(0)
            make.left.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        emailImage.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.leading).inset(16)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(13)
            make.left.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.leading.equalTo(passwordTextField.snp.leading).inset(16)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField).inset(0)
            make.height.equalTo(56)
            make.width.equalTo(36)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(22)
            make.width.equalTo(65)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.right.equalTo(signUpButton.snp.left)
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(signInButton.snp.bottom).offset(26)
        }
    }
    
    func localizedLanguage() {
        emailTextField.placeholder = "SIGN_UP_EMAIL".localized()
        passwordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        signInButton.setTitle("SIGN_IN_BUTTON_UP".localized(), for: .normal)
        signUpButton.setTitle("SIGN_UP_BUTTON".localized(), for: .normal)
        welcomeLabel.text = "HELLO_LABEL".localized()
        signInLabel.text = "DETAIL_SIGN_IN".localized()
        passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        questionLabel.text = "SIGN_IN_QUESTION".localized()
    }
}

//MARK: - UITextFieldDelegate extension
extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
           emailTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
           passwordTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
       }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
           emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
           passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
       }
    }
}

