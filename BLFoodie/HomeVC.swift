//
//  HomeVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/23/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


class HomeVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne =  UINavigationController(rootViewController : FoodCategoryVC(collectionViewLayout : UICollectionViewFlowLayout()))
        let tabOneBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_filled"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = UINavigationController(rootViewController :CartVC(collectionViewLayout : UICollectionViewFlowLayout()))
        let tabTwoBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart"), selectedImage: UIImage(named: "cart_filled"))
        
        tabTwo.tabBarItem = tabTwoBarItem
        
        var tabThree : UIViewController?
        if FoodieUserDefaults().isLoggedIn(){
             tabThree = UINavigationController(rootViewController :UserVC())
        }else{
            tabThree = UINavigationController(rootViewController :SignUpVC())
        }
        let tabThreeBarItem = UITabBarItem(title: "User", image: UIImage(named: "user"), selectedImage: UIImage(named: "user_filled"))
        
        tabThree?.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree!]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
    }
}
