//
//  Movie.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SwiftyJSON

/*{
 "categories": [
   {
     "fileId": 0,
     "id": 0,
     "link": "string",
     "movieCount": 0,
     "name": "string"
   }
 ],
 "categoryAges": [
   {
     "fileId": 0,
     "id": 0,
     "link": "string",
     "movieCount": 0,
     "name": "string"
   }
 ],
 "createdDate": "2023-11-14T20:28:26.523Z",
 "description": "string",
 "director": "string",
 "favorite": true,
 "genres": [
   {
     "fileId": 0,
     "id": 0,
     "link": "string",
     "movieCount": 0,
     "name": "string"
   }
 ],
 "id": 0,
 "keyWords": "string",
 "lastModifiedDate": "2023-11-14T20:28:26.523Z",
 "movieType": "MOVIE",
 "name": "string",
 "poster": {
   "fileId": 0,
   "id": 0,
   "link": "string",
   "movieId": 0
 },
 "producer": "string",
 "screenshots": [
   {
     "fileId": 0,
     "id": 0,
     "link": "string",
     "movieId": 0
   }
 ],
 "seasonCount": 0,
 "seriesCount": 0,
 "timing": 0,
 "trend": true,
 "video": {
   "id": 0,
   "link": "string",
   "number": 0,
   "seasonId": 0
 },
 "watchCount": 0,
 "year": 0
}*/

class Movie {
    public var id: Int = 0
    public var movieType: String = ""
    public var name: String = ""
    public var keyWords: String = ""
    public var description: String = ""
    public var year: Int = 0
    public var trend: Bool = false
    public var timing: Int = 0
    public var director: String = ""
    public var producer: String = ""
    public var poster_link: String = ""
    public var video_link: String = ""
    public var watchCount: Int = 0
    public var seasonCount: Int = 0
    public var seriesCount: Int = 0
    public var createdDate: String = ""
    public var lastModifiedDate: String = ""
    public var screenshots: [Screenshot] = []
    public var categoryAges: [CategoryAge] = []
    public var genres: [Genre] = []
    public var categories: [Category] = []
    public var favorite: Bool = false
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["movieType"].string {
            self.movieType = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["keyWords"].string {
            self.keyWords = temp
        }
        if let temp = json["description"].string {
            self.description = temp
        }
        if let temp = json["year"].int {
            self.year = temp
        }
        if let temp = json["trend"].bool {
            self.trend = temp
        }
        if let temp = json["timing"].int {
            self.timing = temp
        }
        if let temp = json["director"].string {
            self.director = temp
        }
        if let temp = json["producer"].string {
            self.producer = temp
        }
        if json["poster"].exists() {
            if let temp = json["poster"]["link"].string {
                self.poster_link = temp
            }
        }
        if json["video"].exists() {
            if let temp = json["video"]["link"].string {
                self.video_link = temp
            }
        }
        if let temp = json["watchCount"].int {
            self.watchCount = temp
        }
        if let temp = json["seasonCount"].int {
            self.seasonCount = temp
        }
        if let temp = json["seriesCount"].int {
            self.seriesCount = temp
        }
        if let temp = json["createdDate"].string {
            self.createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string {
            self.lastModifiedDate = temp
        }
        if let array = json["screenshots"].array {
            for item in array {
                let temp = Screenshot(json: item)
                self.screenshots.append(temp)
            }
        }
        if let array = json["categoryAges"].array {
            for item in array {
                let temp = CategoryAge(json: item)
                self.categoryAges.append(temp)
            }
        }
        if let array = json["genres"].array {
            for item in array {
                let temp = Genre(json: item)
                self.genres.append(temp)
            }
        }
        if let array = json["categories"].array {
            for item in array {
                let temp = Category(json: item)
                self.categories.append(temp)
            }
        }
        if let temp = json["favorite"].bool {
            self.favorite = temp
        }
    }
}
