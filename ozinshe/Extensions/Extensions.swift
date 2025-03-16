//
//  Extensions.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}