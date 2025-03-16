//
//  SeasonSeriesTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//


import UIKit

class SeasonSeriesTableViewCell: UITableViewCell {

  let identifier = "SeriesCell"
    
    let seriesLabel = {
        let label = UILabel()
        
        label.text = "1 - ші бөлім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let seriesImage = {
        let image = UIImageView()
        image.image = UIImage(named: "seriesImage")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
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
        
        contentView.addSubviews(seriesImage, seriesLabel, grayView)
        
        seriesLabel.snp.makeConstraints { make in
            make.top.equalTo(seriesImage.snp.bottom).offset(8)
            make.right.left.equalToSuperview().inset(24)
        }
        
        seriesImage.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(178)
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(seriesLabel.snp.bottom).offset(16)
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
}