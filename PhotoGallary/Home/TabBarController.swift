//
//  TabBarController.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//


import UIKit
import GoogleSignIn

class TabBarController: UITabBarController {
   //MARK: - IBOutlets
    @IBOutlet weak var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    func setupTabBar() {
        // Create child controllers in code
        let gallaryVC = GallaryVC()
        let profileVC = ProfileVC()
        
        // Assign controllers
        viewControllers = [
            UINavigationController(rootViewController: gallaryVC),
            UINavigationController(rootViewController: profileVC),
        ]
        viewControllers?.enumerated().forEach({ (index,vc) in
            let item = TabBarItem.allCases[index]
            let tabBarItem = UITabBarItem(title: item.name, image: item.icon, selectedImage: item.selectedIcon)
            tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
            tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.whiteBlackTheme], for: .selected)
            vc.tabBarItem = tabBarItem
        })
    }

}
