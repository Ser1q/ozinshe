//
//  ChangePasswordViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//


import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {

    let passwordLabel = {
        let label = UILabel()
        label.text = "Құпиясөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let passwordTextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    let passwordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    lazy var showPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let repeatPasswordLabel = {
        let label = UILabel()
        label.text = "Құпиясөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let repeatPasswordTextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    let repeatPasswordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    lazy var repeatShowPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(repeatShowPasswordTapped), for: .touchUpInside)
        
        return button
    }()
    
    let saveChangesButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        localizeLanguage()
    }
    
    func localizeLanguage() {
        passwordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        repeatPasswordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        saveChangesButton.setTitle("US_INFO_SAVE_BUTTON".localized(), for: .normal)
        passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        navigationItem.title = "CHANGE_PASSWORD_NAVIGATION".localized()
    }
    
    @objc func showPasswordButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func repeatShowPasswordTapped() {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    @objc func saveChangesButtonTapped() {
        let newPassword = passwordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        if  newPassword != repeatPassword {
            SVProgressHUD.showError(withStatus: "Пароли должны совпадать!")
            return
        }
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
            let parameters = ["password": newPassword]
            AF.request(Urls.CHANGE_PASSWORD, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
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
                        self.popViewController()
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
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubviews(passwordLabel, passwordTextField, passwordImage, showPasswordButton, repeatPasswordLabel, repeatPasswordTextField, repeatPasswordImage, repeatShowPasswordButton, saveChangesButton)
        
        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21)
            make.height.equalTo(21)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        passwordImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(passwordTextField.snp.left).offset(16)
            make.centerY.equalTo(passwordTextField)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 56))
            make.right.equalTo(passwordTextField.snp.right)
            make.centerY.equalTo(passwordTextField)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        repeatPasswordImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(repeatPasswordTextField.snp.left).offset(16)
            make.centerY.equalTo(repeatPasswordTextField)
        }
        
        repeatShowPasswordButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 56))
            make.right.equalTo(repeatPasswordTextField.snp.right)
            make.centerY.equalTo(repeatPasswordTextField)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
}