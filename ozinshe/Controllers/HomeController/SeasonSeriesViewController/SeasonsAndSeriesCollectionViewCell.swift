//
//  SeasonsAndSeriesCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit

class SeasonsAndSeriesCollectionViewCell: UICollectionViewCell {
    
    let identifier = "SeasonCell"
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.592, green: 0.325, blue: 0.941, alpha: 1)
        view.layer.cornerRadius = 8
        
       return view
    }()
    
    let seasonLabel = {
        let label = UILabel()
        label.text = "1 сезон"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = .white
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
        
        contentView.addSubviews(backView, seasonLabel)
        
        backView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        seasonLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
}