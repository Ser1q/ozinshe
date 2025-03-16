//
//  MainBannerTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import UIKit
import SnapKit

class MainBannerTableViewCell: UITableViewCell {
    
    var delegate : MovieProtocol?
    
    var mainMovie = MainMovies()

    let identifier = "MainBannerCell"
    
    let bannerCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.itemSize = CGSize(width: 300, height: 220)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bannerCollection.dataSource = self
        bannerCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(mainMovie: MainMovies) {
        
        self.mainMovie = mainMovie
        
        bannerCollection.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        contentView.addSubview(bannerCollection)
        
        bannerCollection.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(272)
        }
    }
}

extension MainBannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.bannerMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        
        cell.setData(bannerMovie: mainMovie.bannerMovie[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.bannerMovie[indexPath.row].movie)
    }

}


