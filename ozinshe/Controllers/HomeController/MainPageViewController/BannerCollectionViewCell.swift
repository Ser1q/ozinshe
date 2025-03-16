//
//  BannerCollectionViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import SnapKit
import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Add UI Elements
    let identifier = "BannerCell"
    
        let titleLabel = {
            let labelCell = UILabel()
            labelCell.text = "Қызғалдақтар мекені"
            labelCell.font = UIFont(name: "SFProDisplay-Bold", size: 14)
            labelCell.textColor = UIColor(named: "111827 - FFFFFF")
        
        return labelCell
    }()
    
        let subtitleLabel = {
            let label = UILabel()
            label.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы"
            label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
            label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
        let image = {
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "bannerImage")
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let genreNameView = {
        let labelView = UIView()
        labelView.backgroundColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        labelView.layer.cornerRadius = 8
        
        return labelView
    }()
    
    let genreNameLabel = {
        let label = UILabel()
        label.text = "Телехикая"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "FFFFFF - 111827")
        
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
    
    func setData(bannerMovie: BannerMovie) {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 164), scaleMode: .aspectFit)
        
        image.sd_setImage(with: URL(string: bannerMovie.link), placeholderImage: nil, context: [.imageTransformer: transformer])
        
        if let categoryName = bannerMovie.movie.categories.first?.name {
            genreNameLabel.text = categoryName
        }
        
        titleLabel.text = bannerMovie.movie.name
        subtitleLabel.text = bannerMovie.movie.description
    }

    func setupUI() {
        
        //MARK: - Add subviews
        addSubviews(titleLabel, subtitleLabel, image, genreNameView)
        genreNameView.addSubview(genreNameLabel)
        
        //MARK: - Constraints
        image.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(16)
    }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
        
        genreNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        
        genreNameLabel.snp.makeConstraints { make in
            make.top.equalTo(genreNameView.snp.top)
            make.bottom.equalTo(genreNameView.snp.bottom)
            make.right.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(8)
        }
    }
}
