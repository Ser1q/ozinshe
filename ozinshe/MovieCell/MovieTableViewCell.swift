//
//  MovieTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    let identifier = "MovieTableCell"
    
    let posterImageView = {
        let cellImageView = UIImageView()
        
        cellImageView.image = UIImage(named: "poster")
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 8
        
        return cellImageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let subtitleLabel = {
        let label = UILabel()
        
        label.text = "2020 • Телехикая • Мультфильм"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        
        return label
    }()
    
    let playView = {
        let view = UIView()
        let imageView = UIImageView()
        let label = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        view.backgroundColor = UIColor(named: "F8EEFF - 1C2431")
        view.layer.cornerRadius = 8
        
        imageView.image = UIImage(named: "play")
        
        label.text = "Қарау"
        label.textColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1)
        label.font =  UIFont(name: "SFProDisplay-Bold", size: 12)
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }

        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(movie: Movie) {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
        
        titleLabel.text = movie.name
        subtitleLabel.text = "\(movie.year) • \(movie.producer) • \(movie.seriesCount) серия"
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(posterImageView, titleLabel, subtitleLabel, playView)

        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.top.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(titleLabel)
        }

        playView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.left.equalTo(subtitleLabel)
        }
    }
}
