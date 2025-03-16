//
//  ScreenshotCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    let identifier = "ScreenshotCell"
    
    let genreImage = {
        let iv = UIImageView()
        iv.image = UIImage(named: "genreImage")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
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
        contentView.addSubview(genreImage)
        
        genreImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}