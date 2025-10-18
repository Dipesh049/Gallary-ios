//
//  TabBarItem.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 15/10/25.
//

import UIKit

enum TabBarItem: String, CaseIterable {
    case gallary
    case profile
}
 
extension TabBarItem {
    
    var icon: UIImage? {
        switch self {
        case .gallary:
            return UIImage(systemName: "photo")?.withTintColor(.whiteBlackTheme.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .profile:
            return UIImage(systemName: "person")?.withTintColor(.whiteBlackTheme.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .gallary:
            return UIImage(systemName: "photo.fill")?.withTintColor(.whiteBlackTheme, renderingMode: .alwaysOriginal)
        case .profile:
            return UIImage(systemName: "person.fill")?.withTintColor(.whiteBlackTheme, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}
