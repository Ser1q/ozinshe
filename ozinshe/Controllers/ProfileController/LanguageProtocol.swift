//
//  LanguageProtocol.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import SnapKit
import UIKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChande()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    var delegate : LanguageProtocol?
    
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let homeView = UIView()
        homeView.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        homeView.layer.cornerRadius = 3
        
        let languageLabel = UILabel()
        languageLabel.text = "Тіл"
        languageLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        languageLabel.textColor = UIColor(named: "111827 - FFFFFF")
        
        view.addSubview(homeView)
        view.addSubview(languageLabel)
        
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 64, height: 5))
            make.centerX.equalToSuperview()
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
        return view
    }()
    
    let langTableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        //Регистрация table view cell
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        
        return tableView
    }()
    
    //MARK: - Licecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapGest()
    
        langTableView.delegate = self
        langTableView.dataSource = self
    }
    
    //MARK: - Add Subviews & Constraints
    func setupUI() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        view.addSubview(backView)
        backView.addSubview(langTableView)
        
        backView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(303)
        }
        
        langTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(98)
            make.right.left.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
//MARK: - Add UITapGestureRecognizer
    func tapGest() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 100 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.backView.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backView))! {
            return false
        }
        
        return true
    }
}
    
//MARK: - Extention Table View
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageTableViewCell
        
        cell.languageLabel.text = languageArray[indexPath.row][0]
        
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            cell.checkImage.image = UIImage(named: "check")
        } else {
            cell.checkImage.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChande()
        dismiss(animated: true, completion: nil)
    }
}
