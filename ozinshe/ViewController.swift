//
//  ViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.10.2024.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SVProgressHUD.show()
    }
    
    @IBAction func button(_ sender: Any) {
        SVProgressHUD.dismiss()
    }
    
}

