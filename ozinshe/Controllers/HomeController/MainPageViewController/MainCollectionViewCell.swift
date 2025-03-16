//
//  MainCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let identifier = "MainCollectionCell"
    
    let image = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mainImage")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Суперкөлік Самұрық"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.numberOfLines = 2
        
        return label
    }()
    
    let subtitleLabel = {
        let label = UILabel()
        label.text = "Мультсериал"
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubviews(image, titleLabel, subtitleLabel)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
    }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(8)
    }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
}