//
//  ProfileViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol {
    
    //MARK: - Add UI Elements
    let profileImageView = {
        let profImageView = UIImageView()
        
        profImageView.image = UIImage(named: "avatar")
        
        return profImageView
    }()
    
    let profileLabel = {
        let label = UILabel()
        
        label.text = "My Profile"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let subtitleProfileLabel = {
        let label = UILabel()
        
        label.text = "ali@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        
        return label
    }()
    
    //MARK: - Language Button Elements
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        return view
    }()
    
    lazy var languageButton = {
        let button = UIButton()
        
        button.setTitle("Language", for: .normal)
        button.setTitleColor(UIColor(named: "111827 - FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let languageLabel = {
        let label = UILabel()
        
        label.text = "English"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        
        return label
    }()
    
    let languageArrowImage = {
        let arrowImage = UIImageView()
        
        arrowImage.image = UIImage(named: "profileArrow")
        
        return arrowImage
    }()
    
    let languageCellView = {
        let cell = UIView()
        
        cell.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1.00)
        
        return cell
    }()
    
    //MARK: - User Info Button Elements
    lazy var userInfoButton = {
        let button = UIButton()
        
        button.setTitle("Personal Information", for: .normal)
        button.setTitleColor(UIColor(named: "111827 - FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(userInfoButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let userInfoLabel = {
        let label = UILabel()
        
        label.text = "Edit"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        
        return label
    }()
    
    let userInfoArrowImage = {
        let arrowImage = UIImageView()
        
        arrowImage.image = UIImage(named: "profileArrow")
        
        return arrowImage
    }()
    
    let userInfoCellView = {
        let cell = UIView()
        
        cell.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1.00)
        
        return cell
    }()
    
    //MARK: - Change Password Button Elements
    lazy var passwordEditButton = {
        let button = UIButton()
        
        button.setTitle("Change Password", for: .normal)
        button.setTitleColor(UIColor(named: "111827 - FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        
        return button
    }()
    
    let passwordArrowImage = {
        let arrowImage = UIImageView()
        
        arrowImage.image = UIImage(named: "profileArrow")
        
        return arrowImage
    }()
    
    let passwordCellView = {
        let cell = UIView()
        
        cell.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1.00)
        
        return cell
    }()
    
    //MARK: - Dark Mode Elements
    let darkModeLabel = {
        let label = UILabel()
        
        label.text = "Dark Mode"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return label
    }()
    
    lazy var darkModeSwitch = {
        let dMSwitch = UISwitch()
        
        dMSwitch.onTintColor = UIColor(red: 0.702, green: 0.463, blue: 0.969, alpha: 1)
        dMSwitch.thumbTintColor = UIColor(red: 0.9, green: 0.91, blue: 0.92, alpha: 1)
        dMSwitch.addTarget(self, action: #selector(changeSwitch), for: .touchUpInside)
        
        return dMSwitch
    }()
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
        localizeLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF - 1C2431")
        navigationItem.title = "Profile"
    }
    
    //MARK: - Add function
    
    func localizeLanguage() {
        navigationItem.title = "PROFILE_TITLE".localized()
        userInfoButton.setTitle("USER_INFO_BUTTON".localized(), for: .normal)
        userInfoLabel.text = "USER_INFO_EDIT_LABEL".localized()
        passwordEditButton.setTitle("CHANGE_PASSWORD_BUTTON".localized(), for: .normal)
        darkModeLabel.text = "DARK_MODE_LABEL".localized()
        profileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
        }
    }
    
    func languageDidChande() {
        localizeLanguage()
    }
    
    @objc func languageButtonTapped() {
        let languageVC = LanguageViewController()
        
        languageVC.modalPresentationStyle = .overFullScreen
        
        languageVC.delegate = self
        
        present(languageVC, animated: true, completion: nil)
    }
    
    @objc func LogOutTapButton() {
        let logOutVC = LogOutViewController()
        
        logOutVC.modalPresentationStyle = .overFullScreen
        
        self.present(logOutVC, animated: true, completion: nil)
    }
    
    @objc func userInfoButtonTapped() {
        let userInfoVc = UserInfoViewController()
        
        userInfoVc.modalPresentationStyle = .fullScreen
        
        navigationController?.show(userInfoVc, sender: self)
        navigationItem.title = ""
    }
    
    @objc func changePasswordTapped() {
        let changePassword = ChangePasswordViewController()
        
        navigationController?.show(changePassword, sender: self)
        navigationItem.title = ""
    }
    
    @objc func changeSwitch(_ dmswitch: UISwitch) {
        if dmswitch.isOn {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        } else {
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
    
    //MARK: - Add Subview & Constraints
    
    func setupUI() {
        view.addSubviews(profileImageView, profileLabel, subtitleProfileLabel, backView)
        
        backView.addSubviews(languageLabel, languageButton, languageArrowImage, languageCellView, userInfoLabel, userInfoButton, userInfoArrowImage, userInfoCellView, passwordArrowImage, passwordEditButton, passwordCellView, darkModeLabel, darkModeSwitch)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logOut"), style: .done, target: self, action: #selector(LogOutTapButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.centerX.equalToSuperview()
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subtitleProfileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(subtitleProfileLabel.snp.bottom).offset(24)
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(languageCellView.snp.top).offset(1)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        languageArrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.left.equalTo(languageLabel.snp.right).offset(8)
            make.centerY.equalTo(languageButton)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
        }
        
        languageCellView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        userInfoButton.snp.makeConstraints { make in
            make.top.equalTo(languageCellView.snp.bottom).inset(1)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        userInfoArrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.left.equalTo(userInfoLabel.snp.right).offset(8)
            make.centerY.equalTo(userInfoButton)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userInfoButton)
        }
        
        userInfoCellView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(userInfoButton.snp.bottom).inset(1)
        }
        
        passwordEditButton.snp.makeConstraints { make in
            make.top.equalTo(userInfoCellView.snp.bottom).offset(1)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        passwordArrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalTo(passwordEditButton)
        }
        
        passwordCellView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(passwordEditButton.snp.bottom).inset(1)
        }
        
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordCellView.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(24)
            make.centerX.equalTo(darkModeSwitch)
        }
        
        darkModeSwitch.snp.makeConstraints { make in
            make.top.equalTo(passwordCellView.snp.bottom).offset(20)
            make.right.equalToSuperview().inset(24)
        }
    }
}