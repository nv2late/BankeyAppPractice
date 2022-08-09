//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Reese on 2022/08/09.
//

import UIKit

import UIKit

extension UIViewController {
    // Old - deprecated iOS 13.0
//    func setStatusBar() {
//        let statusBarSize = UIApplication.shared.statusBarFrame.size // deprecated but OK
//        let frame = CGRect(origin: .zero, size: statusBarSize)
//        let statusbarView = UIView(frame: frame)
//
//        statusbarView.backgroundColor = appColor
//        view.addSubview(statusbarView)
//    }
    
    // New
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()   // 네비바 라인 숨김
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}


