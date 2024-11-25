//
//  SignUpViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 06.11.2024.
//

import UIKit
import Localize_Swift
import SVProgressHUD
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    //MARK: - Private properties
    let helloLabel: UILabel = {
        let label = UILabel()
        
        label.text = "REGISTER".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(resource: .title)
        
        return label
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        
        label.text = "FILL_DATA".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(resource: .description)
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(resource: .title)
        
        return label
    }()
    
    private let passLabel: UILabel = {
        let label = UILabel()
        
        label.text = "PASS".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(resource: .title)
        
        return label
    }()
    
    private let passRepeatLabel: UILabel = {
        let label = UILabel()
        
        label.text = "PASS_REPEAT".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(resource: .title)
        
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .border).cgColor
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.placeholder = "Сіздің email"
        textField.configurePlaceHolder()
        
        textField.addTarget(self, action: #selector(hideWrongLabel), for: .editingChanged)
        
        return textField
    }()
    
    private let passTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .border).cgColor
        textField.textContentType = .password
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.configurePlaceHolder()
        
        
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    private let passRepeatTextField: UITextField = {
        let textField = TextFieldWithPadding()
        
        textField.borderStyle = .none
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .border).cgColor
        textField.textContentType = .password
        textField.placeholder = "YOUR_PASS".localized()
        textField.configurePlaceHolder()
        
        
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .message)
        return imageView
    }()
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        
        label.text = "WRONG_FORMAT".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.isHidden = true
        label.textAlignment = .left
        label.textColor = UIColor(resource: .error)
        
        return label
    }()
    
    private let passImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(resource: .password)
        
        return imageView
    }()
    
    private let passRepeatImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(resource: .password)
        
        return imageView
    }()
    
    private let showButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(resource: .show), for: .normal)
        button.addTarget(self, action: #selector(showPass), for: .touchUpInside)
        
        return button
    }()
    
    private let showRepeatButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(resource: .show), for: .normal)
        button.addTarget(self, action: #selector(showRepeatPass), for: .touchUpInside)
        
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.backgroundColor = UIColor(resource: .primary)
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor(.white), for: .normal)
        button.setTitle("REGISTER".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
    
    private let haveAccLabel: UILabel = {
        let label = UILabel()
        
        label.text = "NO_ACC".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(resource: .noAcc)
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.layer.borderWidth = 0
        button.backgroundColor = .none
        button.setTitleColor(UIColor(resource: .primary300), for: .normal)
        button.setTitle("LOG_IN".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        button.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    
    func initialize(){
        view.backgroundColor = .BG
        
        navigationItem.backBarButtonItem?.title = " "
        let backButton = UIBarButtonItem(image: UIImage(resource: .backButton), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func configureViews(){
        //helloLabel
        view.addSubview(helloLabel)
        
        helloLabel.textAlignment = .left
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 16))
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            make.height.equalTo(dynamicValue(for: 34))
        }
        
        //signInLabel
        view.addSubview(signInLabel)
        
        signInLabel.textAlignment = .left
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            make.height.equalTo(dynamicValue(for: 24))
        }
        
        //Email
        view.addSubview(emailLabel)
        
        emailLabel.textAlignment = .left
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).inset(dynamicValue(for: -32))
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(dynamicValue(for: 21))
        }
        
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-4)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            make.height.equalTo(dynamicValue(for: 56))
        }
        
        view.addSubview(emailImageView)
        
        emailImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.leading).inset(16)
        }
        
        //Wrong Format
        view.addSubview(wrongLabel)
        
        wrongLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(0)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(0)
        }
        
        //Password
        view.addSubview(passLabel)
        
        passLabel.textAlignment = .left
        passLabel.snp.makeConstraints { make in
            make.top.equalTo(wrongLabel.snp.bottom).inset(-16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(dynamicValue(for: 21))
        }
        
        view.addSubview(passTextField)
        
        passTextField.snp.makeConstraints { make in
            make.top.equalTo(passLabel.snp.bottom).inset(-4)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            make.height.equalTo(dynamicValue(for: 56))
        }
        
        view.addSubview(passImageView)
        
        passImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(passTextField)
            make.leading.equalTo(passTextField.snp.leading).inset(16)
        }
        
        view.addSubview(showButton)
        
        showButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(passTextField)
            make.trailing.equalTo(passTextField.snp.trailing).inset(16)
        }
        
        //repeatPassword
        view.addSubview(passRepeatLabel)
        
        passRepeatLabel.textAlignment = .left
        passRepeatLabel.snp.makeConstraints { make in
            make.top.equalTo(passTextField.snp.bottom).inset(-16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(dynamicValue(for: 21))
        }
        
        view.addSubview(passRepeatTextField)
        
        passRepeatTextField.snp.makeConstraints { make in
            make.top.equalTo(passRepeatLabel.snp.bottom).inset(-4)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(dynamicValue(for: 24))
            make.height.equalTo(dynamicValue(for: 56))
        }
        
        view.addSubview(passRepeatImageView)
        
        passRepeatImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(passRepeatTextField)
            make.leading.equalTo(passRepeatTextField.snp.leading).inset(16)
        }
        
        view.addSubview(showRepeatButton)
        
        showRepeatButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(passRepeatTextField)
            make.trailing.equalTo(passRepeatTextField.snp.trailing).inset(16)
        }
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
            make.top.equalTo(passRepeatTextField.snp.bottom).inset(-40)
        }
        
        //GoSignIn
        let miniView = UIView()
        miniView.addSubview(haveAccLabel)
        miniView.addSubview(logInButton)
        
        haveAccLabel.snp.makeConstraints { make in
            make.trailing.equalTo(logInButton.snp.leading).inset(-2)
            make.leading.equalTo(miniView.snp.leading)
            make.centerY.equalTo(miniView)
            make.height.equalTo(22)
        }
        
        logInButton.snp.makeConstraints { make in
            make.trailing.equalTo(miniView.snp.trailing)
            make.centerY.equalTo(miniView)
            make.height.equalTo(22)
        }
        
        view.addSubview(miniView)
        miniView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(signUpButton.snp.bottom).inset(-24)
            make.height.equalTo(22)
        }
    }
    
    @objc func signUp(){
        let pass = passTextField.text ?? ""
        let passRepeat = passRepeatTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if email == "" || pass == "" || passRepeat == ""{
            SVProgressHUD.showError(withStatus: "EMPTY_LOGIN_OR_PASS".localized())
            SVProgressHUD.dismiss(withDelay: 1.5)
        } else if pass != passRepeat{
            SVProgressHUD.showError(withStatus: "DIFF_PASS".localized())
            SVProgressHUD.dismiss(withDelay: 1.5)
        } else if !(email.hasSuffix("@gmail.com") || email.hasSuffix("@mail.com")) {
            emailTextField.layer.borderColor = UIColor(resource: .error).cgColor
            wrongLabel.isHidden = false
            wrongLabel.snp.updateConstraints { make in
                make.height.equalTo(22)
                make.top.equalTo(emailTextField.snp.bottom).inset(-16)
            }
            super.updateViewConstraints()
        } else{
            SVProgressHUD.show()
            
            let parameters = [
                "email": email,
                "password": pass
            ]
            
            AF.request(URLs.SIGN_UP_URL, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
                SVProgressHUD.dismiss()
                
                if let data = response.data{
                    let resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                
                if response.response?.statusCode == 200{
                    let json = JSON(response.data!)
                    print(json)
                    
                    if let token = json["accessToken"].string{
                        Storage.sharedInstance.accessToken = token
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        self.startApp()
                    }
                }
            }
        }
    }
    
    //startUp
    func startApp(){
        let tabVC = TabBarViewController()
        tabVC.modalPresentationStyle = .fullScreen
        self.present(tabVC, animated: true, completion: nil)
    }
    
    //func to hide keyboard
    private func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func goBack(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func showPass(){
        passTextField.isSecureTextEntry.toggle()
    }
    
    @objc func showRepeatPass(){
        passRepeatTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hideWrongLabel(){
        wrongLabel.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(emailTextField.snp.bottom).inset(0)
        }
    }
}


//MARK: - Private extensions
//dynamicValue
private extension SignUpViewController{
    func dynamicValue(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseScreenSize = CGSize(width: 375, height: 812)
        let scaleFactor = min(screenSize.width, screenSize.height) / min(baseScreenSize.width, baseScreenSize.height)
        
        return size * scaleFactor
    }
}


//TextFieldWithPadding
extension SignUpViewController: UITextFieldDelegate{
    class TextFieldWithPadding: UITextField{
        let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16)
        
        func configurePlaceHolder(){
            let placeholderText = self.placeholder ?? " "
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
            ]
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func becomeFirstResponder() -> Bool {
            let result = super.becomeFirstResponder()
            if result {
                // Actions when editing begins
                self.layer.borderColor = UIColor(resource: .primary).cgColor
            }
            return result
        }
        
        override func resignFirstResponder() -> Bool {
            let result = super.resignFirstResponder()
            if result {
                // Actions when editing ends
                self.layer.borderColor = UIColor(resource: .border).cgColor
            }
            return result
        }
    }
}
