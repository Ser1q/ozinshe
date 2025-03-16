//
//  TabBarController.swift
//  ozinshe
//
//  Created by Nuradil Serik on 17.03.2025.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        tabBar.backgroundColor = UIColor(named: "FFFFFF - 1C2431")
    }
    
    func setupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.tabBarItem.selectedImage = UIImage(named: "homeActive")
        
        searchVC.tabBarItem.image = UIImage(named: "search")
        searchVC.tabBarItem.selectedImage = UIImage(named: "searchActive")
        
        favoriteVC.tabBarItem.image = UIImage(named: "favorites")
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "favoritesActive")
        
        profileVC.tabBarItem.image = UIImage(named: "profile")
        profileVC.tabBarItem.selectedImage = UIImage(named: "profileActive")
        profileVC.tabBarItem.badgeColor = UIColor(red: 0.5, green: 0.18, blue: 0.99, alpha: 1)
        
        let navHomeVc = UINavigationController(rootViewController: homeVC)
        let navSearchVc = UINavigationController(rootViewController: searchVC)
        let navFavoriteVc = UINavigationController(rootViewController: favoriteVC)
        let navProfileVc = UINavigationController(rootViewController: profileVC)
        
        setViewControllers([navHomeVc, navSearchVc, navFavoriteVc, navProfileVc], animated: true)
    }
}
