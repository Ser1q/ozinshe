//
//  MoviePlayerViewController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import UIKit
import SnapKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {
    
    var video_link = ""
    
    let player = {
        let view = YouTubePlayerView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        player.loadVideoID(video_link)
    }
}

