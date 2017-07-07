//
//  models.swift
//  Foodie
//
//  Created by Zone 3 on 6/19/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import Foundation
import EVReflection


class FoodCategory : EVObject{
    var name : String = ""
    var id : Int = 0
    var pics : String = ""
    var foods : [String] = []
    var catDescription : String = ""

}

class FoodItem: EVObject {
    
    var name : String = ""
    var id : Int = 0
    var pics : String = ""
    var price : String = ""
    var foodDescription : String = ""
    var extras : [String] = []

}

class Order: EVObject {
    let id : Int = 0
    let foodItem : FoodItem?
    var status : Status? = .addedToCart
    var quantity : Int = 0
    
    init(food:FoodItem, quan : Int){
        foodItem = food
        quantity = quan
        status = .addedToCart
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }

}

class  User : EVObject {
    var name : String = ""
    var address : String = ""
    var email : String = ""
    var orders : [Order]? = []
    var favorite : [FoodItem]? = []
    var pics : String? = ""
    var id : Int? = 0
    
    init(name: String, address: String, email: String) {
        self.name = name
        self.address = address
        self.email = email
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}



enum Status : String {
    case addedToCart
    case inTransit
    case delivered

}
