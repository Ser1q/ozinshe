//
//  HistoryTableViewCell.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//


import UIKit
import SnapKit
import SDWebImage

class HistoryTableViewCell: UITableViewCell {

    var mainMovie = MainMovies()
    
    var delegate : MovieProtocol?
    
    let identifier = "HistoryCell"
    
    let historyCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: -36, right: 24)
        layout.itemSize = CGSize(width: 184, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "HistoryCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Қарауды жалғастырыңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        historyCollection.dataSource = self
        historyCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(mainMovie: MainMovies) {
        
        self.mainMovie = mainMovie
        
        historyCollection.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(historyCollection, titleLabel)
        
        historyCollection.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(19)
        }
    }
}

extension HistoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionCell", for: indexPath) as! HistoryCollectionViewCell
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
        cell.image.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link), placeholderImage: nil, context: [.imageTransformer: transformer])
        cell.image.layer.cornerRadius = 8
        
        cell.titleLabel.text = mainMovie.movies[indexPath.row].name
        
        if let genrename = mainMovie.movies[indexPath.row].genres.first {
            cell.subtitleLabel.text = genrename.name
        } else {
            cell.subtitleLabel.text = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }
}
