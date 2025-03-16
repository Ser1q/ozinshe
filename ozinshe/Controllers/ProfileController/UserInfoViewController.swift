//
//  UserInfoViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//


import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class UserInfoViewController: UIViewController {
    
    var userID: Int?
    
    let yourNameLabel = {
        let label = UILabel()
        label.text = "Сіздің атыңыз"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let nameTextField = {
        let textField = UITextField()
        textField.placeholder = "Атыңынызды енгізіңіз..."
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    let grayView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let emailTextField = {
        let textField = UITextField()
        textField.placeholder = "ali@gmail.com"
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    let grayView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    let phoneLabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let phoneTextField = {
        let textField = UITextField()
        textField.placeholder = "+7 702 732-10-31"
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    let grayView3 = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    let birthLabel = {
        let label = UILabel()
        label.text = "Туылған күні"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let birthTextField = {
        let textField = UITextField()
        textField.placeholder = "2005-01-28"
        textField.textColor = UIColor(named: "111827 - FFFFFF")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    let grayView4 = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    lazy var saveChangesButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveInfoButton), for: .touchUpInside)
        
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        downloadPersonalInfo()
        localizeLanguage()
    }
    
    //MARK: - Add functions
    func localizeLanguage() {
        navigationItem.title = "USER_INFO_NAVIGATION".localized()
        yourNameLabel.text = "USER_INFO_NAME_LABEL".localized()
        nameTextField.placeholder = "USER_INFO_NAME_TEXT_FIELD".localized()
        phoneLabel.text = "US_INFO_PHONE_LABEL".localized()
        birthLabel.text = "US_INFO_BIRTH_LABEL".localized()
        saveChangesButton.setTitle("US_INFO_SAVE_BUTTON".localized(), for: .normal)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func downloadPersonalInfo() {
        SVProgressHUD.show()
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.UPLOAD_USER_INFO, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                let name = json ["name"]
                let email = json ["user"]["email"]
                let phoneNumber = json["phoneNumber"]
                let birthDate = json ["birthDate"]
                self.userID = json ["id"].int
                self.nameTextField.text = name.stringValue
                self.emailTextField.text = email.stringValue
                self.phoneTextField.text = phoneNumber.stringValue
                self.birthTextField.text = birthDate.stringValue
            } else {
                SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())

                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    @objc func saveInfoButton() {
        let updatedName = nameTextField.text ?? ""
        let updatedEmail = emailLabel.text ?? ""
        let updatedBirth = birthTextField.text ?? ""
        let updatedPhone = phoneTextField.text ?? ""
        
        updateUserInfo(updatedName: updatedName, updatedEmail: updatedEmail, updatedBirth: updatedBirth, updatedPhone: updatedPhone)
    }
    
    func updateUserInfo(updatedName: String, updatedEmail: String, updatedBirth: String, updatedPhone: String) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        let parameters: [String: Any] = [
            "name": updatedName,
            "email": updatedEmail,
            "phoneNumber": updatedPhone,
            "birthDate": updatedBirth,
            ]
        
        AF.request(Urls.UPLOAD_USER_INFO, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                SVProgressHUD.dismiss()
                var resultString = ""
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
            
                if response.response?.statusCode == 200 {
                    print("User information updated successfully")
                    
                    self.navigationController?.popViewController(animated: true)
                } else {
                    SVProgressHUD.showError(withStatus: resultString)
    
                    let errorString = "CONNECTION_ERROR".localized() + " \(response.response?.statusCode ?? -1) \(resultString)"
                    SVProgressHUD.showError(withStatus: errorString)
                }
            }
    }
    
    //MARK: - Add subviews & constraints
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        navigationItem.title = "Персональная информация"
        
        view.addSubviews(yourNameLabel, nameTextField, grayView, emailLabel, emailTextField, grayView2, phoneLabel, phoneTextField, grayView3, birthLabel, birthTextField, grayView4, saveChangesButton)
        
        yourNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(yourNameLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(33)
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
        
        grayView2.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView2.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
        
        grayView3.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView3.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
        
        grayView4.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(56)
        }
    }
}