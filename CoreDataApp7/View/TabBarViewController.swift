//
//  TabBarViewController.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            //delegate = self
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let item1 = ViewController()
            let item2 = FavoritesViewController()
            let icon2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
            
            //item1.tabBarItem = UIImage(systemName: "house")
            item2.tabBarItem = icon2
            
            item1.title = "Home"
            item2.title = "Bookmarks"
            
            let controllers = [item1, item2]  //array of the root view controllers displayed by the tab bar interface

            if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
                        //tabBarItem1.title = "house"
                        tabBarItem1.image = UIImage(systemName: "house - This String doesn't matter")
                        //tabBarItem1.selectedImage = UIImage(systemName: "m.square")
                item1.tabBarItem = tabBarItem1
                    }
            item1.tabBarItem.image = UIImage(systemName: "house")
            
            
            
            self.viewControllers = controllers
            
            self.selectedIndex = 0
            
        }

        //Delegate methods
        func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            print("Should select viewController: \(viewController.title ?? "") ?")
            return true;
        }


}

