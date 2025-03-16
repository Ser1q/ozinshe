//
//  SignUpViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 06.11.2024.
//

import UIKit
import SnapKit
import SVProgressHUD
import Localize_Swift
import SwiftyJSON
import Alamofire

class SignUpViewController: UIViewController {
    
    let welcomeLabel = {
        let label = UILabel()
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз"
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
        button.addTarget(self, action: #selector(showPassTapped), for: .touchUpInside)
        
        return button
    }()
    
    let repeatPasswordLabel = {
        let label = UILabel()
        label.text = "Құпиясөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let repeatPasswordTextField = {
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

    let repeatPasswordImage = {
        let iv = UIImageView()
        iv.image = UIImage(named: "password")
        
        return iv
    }()
    
    lazy var repeatShowPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(repeatShowPassTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signInButton = {
        let button = UIButton()
        button.setTitle("Kіру", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00), for: .normal)
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        return button
    }()

    let questionLabel = {
        let label = UILabel()
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
        label.textAlignment = .right
        
        return label
    }()
    
    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        hideKeyboardWhenTappedAround()
        localizedLanguage()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
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
    
    @objc func showPassTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func repeatShowPassTapped() {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    @objc func signInTapped() {
        let signInViewController = SignInViewController()
        
        navigationController?.show(signInViewController, sender: self)
        navigationItem.title = ""
    }
    
    @objc func signUpTapped() {
        let signUpEmail = emailTextField.text!
        let signUpPassword = passwordTextField.text!
        let confirmPassword = repeatPasswordTextField.text!
        
        if signUpPassword == confirmPassword {
            
        SVProgressHUD.show()
        let parameters = ["email": signUpEmail, "password": signUpPassword]
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
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
            print("Registration is successful")
        } else {
            showAlert(message: "Try again")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startApp() {
        let tabViewController = TabBarController()
        tabViewController.modalPresentationStyle = .fullScreen
        self.present(tabViewController, animated: true, completion: nil)
    }

    //MARK: - Add Subviews & Constraints
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")

        view.addSubviews(welcomeLabel, signUpLabel, emailLabel, emailTextField, emailImage, passwordLabel, passwordTextField, passwordImage, showPasswordButton, repeatPasswordLabel, repeatPasswordTextField, repeatPasswordImage, repeatShowPasswordButton, signUpButton, questionLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(0)
            make.left.equalToSuperview().inset(24)
        }
      
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(32)
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
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(13)
            make.left.equalToSuperview().inset(24)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        repeatPasswordImage.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.leading.equalTo(repeatPasswordTextField.snp.leading).inset(16)
        }
  
        repeatShowPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(repeatPasswordTextField)
            make.right.equalTo(repeatPasswordTextField).inset(0)
            make.height.equalTo(56)
            make.width.equalTo(36)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(18)
            make.height.equalTo(22)
            make.width.equalTo(50)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.right.equalTo(signInButton.snp.left)
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(signUpButton.snp.bottom).offset(26)
        }
    }
    
    func localizedLanguage() {
        welcomeLabel.text = "SIGN_UP_LABEL".localized()
        signUpLabel.text = "DETAIL_INFORM_LABEL".localized()
        emailTextField.placeholder = "SIGN_UP_EMAIL".localized()
        passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        repeatPasswordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        questionLabel.text = "SIGN_UP_QUESTION_LABEL".localized()
        signUpButton.setTitle("SIGN_UP_BUTTON".localized(), for: .normal)
        signInButton.setTitle("SIGN_IN_BUTTON_UP".localized(), for: .normal)
    }
}

//MARK: - UITextFieldDelegate extension
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
            passwordTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == repeatPasswordTextField {
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == passwordTextField {
            passwordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        } else if textField == repeatPasswordTextField {
            repeatPasswordTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        }
    }
}
