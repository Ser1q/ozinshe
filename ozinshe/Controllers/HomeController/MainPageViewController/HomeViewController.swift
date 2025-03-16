//
//  HomeViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, MovieProtocol {
    
    var mainMovies: [MainMovies] = []
    
    //MARK: - Add TableView
    let tableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        //Регистрация table view cell
        tableView.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "MainBannerCell")
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: "GenreCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        downloadMainBanners()
        addNavBarImage()
    }
    
    func addNavBarImage() {
        let image = UIImage(named: "logoMainPage")
        
        let logoImageView = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    func setupUI() {
      
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    // MARK: - downloads
    // step 1
    func downloadMainBanners() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .mainBanner
                    for item in array {
                        let bannerMovie = BannerMovie(json: item)
                        movie.bannerMovie.append(bannerMovie)
                    }
                    self.mainMovies.append(movie)
                    self.tableView.reloadData()
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
            self.downloadUserHistory()
        }
    }
    
    // step 2
    func downloadUserHistory() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.USER_HISTORY_URL, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .userHistory
                    for item in array {
                        let historyMovie = Movie(json: item)
                        movie.movies.append(historyMovie)
                    }
                    if array.count > 0 {
                        self.mainMovies.append(movie)
                    }
                    self.tableView.reloadData()
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
            self.downloadMainMovies()
        }
    }
    
    // step 3
    func downloadMainMovies() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.MAIN_MOVIES_URL, method: .get, headers: headers).responseData { response in
            
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
                        let movie = MainMovies(json: item)
                        self.mainMovies.append(movie)
                    }
                    self.tableView.reloadData()
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
            self.downloadGenres()
        }
    }
    
    // step 4
    func downloadGenres() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_GENRES, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .genre
                    for item in array {
                        let genre = Genre(json: item)
                        movie.genres.append(genre)
                    }
                    if self.mainMovies.count > 4 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(movie, at: 4)
                        } else {
                            self.mainMovies.insert(movie, at: 3)
                        }
                    } else {
                        self.mainMovies.append(movie)
                    }
                    self.tableView.reloadData()
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
            self.downloadCategoryAges()
        }
    }
    
    // step 5
    func downloadCategoryAges() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_AGES, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .ageCategory
                    for item in array {
                        let ageCategory = CategoryAge(json: item)
                        movie.categoryAges.append(ageCategory)
                    }
                    if self.mainMovies.count > 8 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(movie, at: 8)
                        } else {
                            self.mainMovies.insert(movie, at: 7)
                        }
                    } else {
                        self.mainMovies.append(movie)
                    }
                    self.tableView.reloadData()
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //mainBanner
        if mainMovies[indexPath.row].cellType == .mainBanner {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainBannerCell", for: indexPath) as! MainBannerTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])
            cell.delegate = self

            return cell
        }
        
        //userHistory
        if mainMovies[indexPath.row].cellType == .userHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])
            cell.delegate = self

            return cell
        }
        
        //genre or ageCategory
        if mainMovies[indexPath.row].cellType == .genre || mainMovies[indexPath.row].cellType == .ageCategory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreTableViewCell

            cell.setData(mainMovie: mainMovies[indexPath.row])

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell

        cell.setData(mainMovie: mainMovies[indexPath.row])
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if mainMovies[indexPath.row].cellType == .mainBanner {
            return 272.0
        }
        if mainMovies[indexPath.row].cellType == .userHistory {
            return 228.0
        }
        if mainMovies[indexPath.row].cellType == .genre ||
           mainMovies[indexPath.row].cellType == .ageCategory {
            return 184.0
        }
        // mainMovie
            return 288.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mainMovies[indexPath.row].cellType != .mainMovie {
            return
        }
        
        let categoryTableViewController = CategoryTableViewController()
        categoryTableViewController.categoryID = mainMovies[indexPath.row].categoryId
        categoryTableViewController.categoryName = mainMovies[indexPath.row].categoryName
        navigationItem.title = ""
        
        navigationController?.show(categoryTableViewController, sender: self)
    }
    
    // MARK: - MovieProtocol
    func movieDidSelect(movie: Movie) {
        let movieInfoVC = MovieInfoController()
        
        movieInfoVC.movie = movie
          
        navigationController?.show(movieInfoVC, sender: self)
    }
}

