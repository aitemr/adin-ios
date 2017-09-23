//
//  MainTabBarController.swift
//  ADIN
//
//  Created by Islam Temirbek on 10/10/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit

struct MainTabBarItem {
    var icon: (UIImage?, UIImage?)
    var controller: UIViewController
}

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItems = [
            MainTabBarItem(icon: (Icon.homeIcon, Icon.homeSelectedIcon), controller: PlaceViewController()),
            MainTabBarItem(icon: (Icon.chatIcon, Icon.chatSelectedIcon), controller: ConversationsViewController()),
            MainTabBarItem(icon: (Icon.profileIcon, Icon.profileSelectedIcon), controller: ProfileViewController())
        ]
        
        viewControllers = tabBarItems.flatMap {
            UINavigationController(rootViewController: $0.controller).then {
                let strokeLayer = CAShapeLayer()
                strokeLayer.path = UIBezierPath(rect:
                    CGRect(x: 0, y: ($0.navigationBar.frame.height),
                           width: UIScreen.main.bounds.width, height: 0.5)).cgPath
                strokeLayer.fillColor = UIColor.gray.cgColor
                $0.navigationBar.tintColor = .black
                $0.navigationBar.barTintColor = .alabaster
                $0.navigationBar.layer.addSublayer(strokeLayer)
            }
        }
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        for (index, item) in tabBarItems.enumerated() {
            setUpTabBarItem(tabBar.items![index],
                            image: item.icon.0,
                            selectedImage: item.icon.1)
        }
        
        guard let items = self.tabBar.items else { return }
        for item in items as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(tintColor: .black).withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    // MARK: Setup
    
    fileprivate func setUpTabBarItem(_ tabBarItem: UITabBarItem?,
                                     image: UIImage?,
                                     selectedImage: UIImage?) {
        tabBarItem?.image = image
        tabBarItem?.selectedImage = selectedImage
        tabBarItem?.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
    }
}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


