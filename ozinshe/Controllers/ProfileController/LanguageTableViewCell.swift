//
//  LanguageTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit

class LanguageTableViewCell: UITableViewCell {

    let identifier = "LanguageCell"
  
    let languageLabel = {
        let label = UILabel()
        label.text = "Қазақша"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let checkImage = {
        let image = UIImageView()
        image.image = UIImage(named: "check")
        
        return image
    }()
    
    let grayView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(languageLabel, checkImage, grayView)
        
        languageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        checkImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        grayView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
