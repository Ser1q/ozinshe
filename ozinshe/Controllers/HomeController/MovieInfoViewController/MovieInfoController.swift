//
//  MovieInfoController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import SDWebImage
import UIGradient

class MovieInfoController: UIViewController {
    
    var movie = Movie()
    
    var similarMovies:[Movie] = []
    
    let movieScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentMode = .scaleToFill
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    let movieContentView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        return view
    }()
   
    let posterImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let gradientLayer = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 393, height: 364))
        view.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: CGRect(x: 0, y: 0, width: 393, height: 364), colors: [UIColor.clear, UIColor.black], locations: [0.5, 1.0])
        return view
    }()
    
    lazy var arrowButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var playButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        button.addTarget(self, action: #selector(shareMovie), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteButton"), for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    let favoriteButtonLabel = {
        let label = UILabel()
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        return label
    }()
    
    let shareButtonLabel = {
        let label = UILabel()
        label.text = "Бөлісу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.82, green: 0.835, blue: 0.859, alpha: 1)
        return label
    }()

    let backgroundView = {
        let viewBack = UIView()
        viewBack.contentMode = .scaleToFill
        viewBack.layer.cornerRadius = 32
        viewBack.backgroundColor = UIColor(named: "FFFFFF - 111827")
        viewBack.clipsToBounds = true
        viewBack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return viewBack
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.text = "Айдар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.text = "2020 • Телехикая • 5 сезон, 46 серия, 7 мин"
        label.textColor = UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        return label
    }()
    
    let grayView1 = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады."
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00)
        label.numberOfLines = 20
        return label
    }()
    
    lazy var fullDescriptionButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(fullDescription), for: .touchUpInside)
        return button
    }()
    
    let directorLabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let directorNameLabel = {
        let label = UILabel()
        label.text = "Бақдәулет Әлімбеков"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let producerNameLabel = {
        let label = UILabel()
        label.text = "Сандуғаш Кенжебаева"
        label.textColor = UIColor(red: 0.294, green: 0.333, blue: 0.388, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let grayView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1)
        return view
    }()
        
    let seasonsLabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    lazy var seasonsButton = {
        let button = UIButton()
        button.setTitle("5 сезон, 46 серия", for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor(red: 0.612, green: 0.639, blue: 0.686, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
        return button
    }()
    
    let arrowImage = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrowImage")
        return iv
    }()
    
    let screenshotsLabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    let similarMoviesLabel = {
        let label = UILabel()
        label.text = "Ұқсас телехикаялар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    //MARK: - Collection View
    let screenshotsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "ScreenshotCell")

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()
    
    let similarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 208)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: "SimilarCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        return collectionView
    }()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setData()
        buttonsSettings()
        downloadSimilar()
        localizeLanguage()
        
        screenshotsCollectionView.delegate = self
        screenshotsCollectionView.dataSource = self
        
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
            decriptionNumber()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func decriptionNumber() {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubview(movieScrollView)
        movieScrollView.addSubview(movieContentView)
        
        movieContentView.addSubviews(posterImageView, gradientLayer, arrowButton, favoriteButton, shareButton, playButton, favoriteButtonLabel, shareButtonLabel, backgroundView)
        
        backgroundView.addSubviews(nameLabel, detailLabel, grayView1, descriptionLabel, fullDescriptionButton, directorLabel, producerLabel, directorNameLabel, producerNameLabel, grayView2, seasonsLabel, seasonsButton, arrowImage, screenshotsLabel, screenshotsCollectionView, similarMoviesLabel, similarCollectionView)
        
        movieScrollView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        
        movieContentView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.top.equalTo(movieScrollView.contentLayoutGuide.snp.top)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(364)
        }
        
        gradientLayer.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(364)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().inset(54)
            make.size.equalTo(CGSize(width: 95, height: 100))
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(37)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().inset(228)
        }
        
        favoriteButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.top).offset(46)
        }
        
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(37)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().inset(228)
        }
        
        shareButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton)
            make.top.equalTo(shareButton.snp.top).offset(46)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(198)
            make.size.equalTo(CGSize(width: 132, height: 132))
            make.centerX.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(324)
            make.right.left.bottom.equalToSuperview()
        }
        
        //MARK: - Background View Constraints
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(24)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        grayView1.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(detailLabel.snp.bottom).offset(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView1.snp.bottom).offset(24)
            make.right.left.equalToSuperview().inset(24)
            make.width.equalTo(345)
        }
        
        fullDescriptionButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        
        directorNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(113)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
        }
        
        producerNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(113)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(directorNameLabel.snp.bottom).offset(8)
        }

        grayView2.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.top.equalTo(producerNameLabel.snp.bottom).offset(24)
        }
        
        seasonsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(grayView2.snp.bottom).offset(24)
        }
        
        seasonsButton.snp.makeConstraints { make in
            make.left.equalTo(seasonsLabel.snp.right)
            make.right.equalToSuperview().inset(45)
            make.centerY.equalTo(seasonsLabel)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(seasonsLabel)
        }
        
        screenshotsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(seasonsLabel.snp.bottom).offset(32)
        }
        
        screenshotsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(screenshotsLabel.snp.bottom).offset(16)
            make.height.equalTo(112)
        }
        
        similarMoviesLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotsCollectionView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(similarMoviesLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(220)
        }
    }
    
    func buttonsSettings() {
        if movie.movieType == "MOVIE" {
            seasonsLabel.isHidden = true
            seasonsButton.isHidden = true
            arrowImage.isHidden = true
            
            screenshotsLabel.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(24)
                make.top.equalTo(grayView2.snp.bottom).offset(24)
            }
        } else {
            seasonsButton.setTitle("\(movie.seasonCount) сезон, \(movie.seriesCount) серия", for: .normal)
        }
        
        if descriptionLabel.numberOfLines < 5 {
            fullDescriptionButton.isHidden = true
        }
        
        if movie.favorite {
            favoriteButton.setImage(UIImage(named: "favoriteSelectedButton"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favoriteButton"), for: .normal)
        }
    }
    
        func setData() {
            posterImageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
            
            nameLabel.text = movie.name
            detailLabel.text = "\(movie.year)"
            
            for item in movie.genres {
                detailLabel.text = detailLabel.text! + " • " + item.name
            }
            descriptionLabel.text = movie.description
            
            directorNameLabel.text = movie.director
            
            producerNameLabel.text = movie.producer
        }
    
    //MARK: - Localize elements
    func localizeLanguage() {
        shareButtonLabel.text = "SHARE_LABEL".localized()
        favoriteButtonLabel.text = "ADD_TO_FAVORITE".localized()
        fullDescriptionButton.setTitle("FULL_DESCRIPTION_BUTTON".localized(), for: .normal)
        directorLabel.text = "DIRECTOR_LABEL".localized()
        producerLabel.text = "PRODUCER_LABEL".localized()
        seasonsLabel.text = "SERIES_LABEL".localized()
        screenshotsLabel.text = "SCREENSHOT_LABEL".localized()
        similarMoviesLabel.text = "SIMILAR_MOVIES_LABEL".localized()
    }
    
    //MARK: - Add function
    func downloadSimilar() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SIMILAR + String(movie.id), method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let movie = Movie(json: item)
                        self.similarMovies.append(movie)
                    }
                    self.similarCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    //MARK: - objc function
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func playMovieTapped() {
        if movie.movieType == "MOVIE" {
            let playerVC = MoviePlayerViewController()
            
            playerVC.video_link = movie.video_link
            
            navigationController?.show(playerVC, sender: self)
            navigationItem.title = ""
        } else {
            let seasonsVC = SeasonsAndSeriesViewController()
            
            seasonsVC.movie = movie
            
            navigationController?.show(seasonsVC, sender: self)
            navigationItem.title = ""
        }
    }
    
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        let parameters = ["movieId": movie.id] as [String : Any]
        
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
//                let json = JSON(response.data!)
//                print("JSON: \(json)")
                
                self.movie.favorite.toggle()
                
                self.buttonsSettings()
                
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    @objc func shareMovie() {
        let text = "\(movie.name) \n\(movie.description)"
        let image = posterImageView.image
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
  @objc func fullDescription() {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("Толығырақ", for: .normal)
        } else {
            descriptionLabel.numberOfLines = 30
            fullDescriptionButton.setTitle("Жасыру", for: .normal)
        }
    }
}

    //MARK: - Extension UICollectionViewDelegate
    extension MovieInfoController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.similarCollectionView {
                return similarMovies.count
            }
            return movie.screenshots.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == self.similarCollectionView {
                let similarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCell", for: indexPath) as! SimilarCollectionViewCell
                
                let transformer = SDImageResizingTransformer(size: CGSize(width: 112, height: 164), scaleMode: .aspectFill)
                
                similarCell.imageVi.sd_setImage(with: URL(string: similarMovies[indexPath.row].poster_link), placeholderImage: nil, context: [.imageTransformer: transformer])
                similarCell.imageVi.layer.cornerRadius = 8
                
                similarCell.movieNameLabel.text = similarMovies[indexPath.row].name
                
                if let genrename = similarMovies[indexPath.row].genres.first {
                    similarCell.movieGenreNameLabel.text = genrename.name
                } else {
                    similarCell.movieGenreNameLabel.text = ""
                }
                return similarCell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! ScreenshotCollectionViewCell
            
            let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
            
            cell.genreImage.layer.cornerRadius = 8
            
            cell.genreImage.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == self.similarCollectionView {
                let movieinfoVC = MovieInfoController()
                
                movieinfoVC.movie  = similarMovies[indexPath.row]
                navigationItem.title = ""
                
                navigationController?.show(movieinfoVC, sender: self)
            }
        }
}
