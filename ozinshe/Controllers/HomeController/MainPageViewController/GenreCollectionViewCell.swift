//
//  GenreCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    let identifier = "GenreCollectionCell"
    
    let image = {
        let iv = UIImageView()
        iv.image = UIImage(named: "genreImage")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Мультфильм"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        
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
        
        contentView.addSubviews(image, titleLabel)
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
