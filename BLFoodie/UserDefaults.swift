//
//  UserDefaults.swift
//  Foodie
//
//  Created by Zone 3 on 6/24/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import Foundation


class FoodieUserDefaults{

    var defaults : UserDefaults?
    var className = String(describing: "\(FoodieUserDefaults.self)")
    
    init() {
        defaults =  UserDefaults.standard
    }
    
    
    class func cacheUserAcctDetails(accountObj : String){
        UserDefaults.standard.set(accountObj, forKey: "\(String(describing: "\(FoodieUserDefaults.self)")).userAcct")
    }
    
    func setEmail(email: String) {
        defaults?.set(email, forKey: "\(className).email")
    }
    
    func getEmail() -> String{
        return (defaults?.string(forKey: "\(className).email"))!
    }
    
    
    func setloggedIn(status : Bool){
        defaults?.set(status, forKey: "\(className).isReg")
    }
    
    func isLoggedIn() -> Bool {
        return (defaults?.bool(forKey: "\(className).isReg"))!
    }
    
    func setOrder(order: [String])  {
        defaults?.set(order, forKey: "\(className).order")
    }

    func getOrders() -> [String]{
        return defaults?.array(forKey: "\(className).order") as! [String]
    }
    
    func setCart(cart: [String])  {
        defaults?.set(cart, forKey: "\(className).cart")
    }
    
    func getCart() -> [String]{
        return defaults?.array(forKey: "\(className).cart") as! [String]
    }
    
    func setFav(fav: [String])  {
        defaults?.set(fav, forKey: "\(className).fav")
    }
    
    func getFav() -> [String]{
        return defaults?.array(forKey: "\(className).fav") as! [String]
    }
}
