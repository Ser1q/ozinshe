//
//  Screenshot.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit
import SwiftyJSON

class Screenshot {
    public var id: Int = 0
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
