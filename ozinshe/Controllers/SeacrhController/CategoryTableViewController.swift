//
//  CategoryTableViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class CategoryTableViewController: UITableViewController {
    
    let identifier = "SearchTableViewController"

    var categoryID = 0
    var categoryName = ""
    
    var isLoading: Bool = false
    
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableCell")
        
        self.title = categoryName
        navigationItem.title = ""
        
        downloadMoviesByCategory()
    }
    
    @objc func handleRefresh() {
        if !isLoading {
            isLoading = true
            movies.removeAll()
            tableView.reloadData()
            downloadMoviesByCategory()
        }
    }
    
    func downloadMoviesByCategory() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        let parametres = ["categoryId": categoryID]
        
        self.isLoading = false
        self.refreshControl?.endRefreshing()
        
        AF.request(Urls.MOVIES_BY_CATEGORY_URL, method: .get, parameters: parametres, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if json["content"].exists() {
                    if let array = json["content"].array {
                        for item in array {
                            let movie = Movie(json: item)
                            self.movies.append(movie)
                        }
                        self.tableView.reloadData()
                    } else {
                        SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                    }
                } else {
                    var ErrorString = "CONNECTION_ERROR".localized()
                    if let sCode = response.response?.statusCode {
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableViewCell
        
        cell.setData(movie: movies[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieinfoVC = MovieInfoController()
        
        movieinfoVC.movie  = movies[indexPath.row]
        
        navigationController?.show(movieinfoVC, sender: self)
    }
}
