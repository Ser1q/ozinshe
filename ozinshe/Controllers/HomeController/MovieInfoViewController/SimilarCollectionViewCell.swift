//
//  SimilarCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    
    let identifier = "SimilarCell"
    
    let imageVi = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mainImage")
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let movieNameLabel = {
        let label = UILabel()
        label.text = "Суперкөлік Самұрық"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.numberOfLines = 2
        
        return label
    }()
    
    let movieGenreNameLabel = {
        let label = UILabel()
        label.text = "Мультсериал"
        label.textColor = UIColor(named: "111827 - FFFFFF")
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
        
        contentView.addSubviews(imageVi, movieNameLabel, movieGenreNameLabel)
        
        imageVi.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
    }
        
        movieNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(imageVi.snp.bottom).offset(8)
    }
        movieGenreNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
}
