//
//  GenreTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit
import SDWebImage

class GenreTableViewCell: UITableViewCell {

   let identifier = "GenreCell"
    
    var mainMovie = MainMovies()
    
    let genreCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: -36, right: 24)
        layout.itemSize = CGSize(width: 184, height: 112)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Жанрды таңдаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        genreCollection.dataSource = self
        genreCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(mainMovie: MainMovies) {
        
        self.mainMovie = mainMovie
        
        genreCollection.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(genreCollection, titleLabel)
        
        genreCollection.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
    }
}

extension GenreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory {
            return mainMovie.categoryAges.count
        }
        return mainMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as! GenreCollectionViewCell
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
        cell.image.layer.cornerRadius = 8
        
        //movieNameLabel
       
        if mainMovie.cellType == .ageCategory {
            cell.image.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])
            cell.titleLabel.text = mainMovie.categoryAges[indexPath.row].name
        } else {
            cell.image.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])
            titleLabel.text = mainMovie.genres[indexPath.row].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
