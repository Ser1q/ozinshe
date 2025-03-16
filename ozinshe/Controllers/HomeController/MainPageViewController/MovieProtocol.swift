//
//  MovieProtocol.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit
import SDWebImage

protocol MovieProtocol {
    func movieDidSelect(movie: Movie)
}

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }

        return attributes
    }
}

class MainTableViewCell: UITableViewCell {

    var delegate : MovieProtocol?
    
    var mainMovie = MainMovies()
    
    let identifier = "MainCell"
    
    let mainCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: -36, right: 24)
        layout.itemSize = CGSize(width: 112, height: 220)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Телехикая"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Барлығы"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.702, green: 0.463, blue: 0.969, alpha: 1)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainCollection.dataSource = self
        mainCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(mainMovie: MainMovies) {
        titleLabel.text = mainMovie.categoryName
        
        self.mainMovie = mainMovie
        
        mainCollection.reloadData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(mainCollection, titleLabel, allLabel)
        
        mainCollection.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(24)
            make.right.equalTo(allLabel.snp.left).inset(-10)
        }
        
        allLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.right.equalToSuperview().inset(24)
        }
    }
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionCell", for: indexPath) as! MainCollectionViewCell
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 112, height: 164), scaleMode: .aspectFill)
        
        cell.image.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link), placeholderImage: nil, context: [.imageTransformer: transformer])
        cell.image.layer.cornerRadius = 8
        
        //movieNameLabel
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
