//
//  TextFieldWithPadding.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//



import Foundation
import UIKit

class TextFieldWithPadding: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
