//
//  Category.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import Foundation
import SwiftyJSON

class Category {
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
