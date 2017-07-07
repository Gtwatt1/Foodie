//
//  Daos.swift
//  Foodie
//
//  Created by Zone 3 on 6/24/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import Foundation
import RealmSwift


class Daos{
    
    let realm: Realm = try! Realm()

    func save<T>(cat : T) -> () {
        
        try! realm.write {
            realm.add(cat as! Object, update: true)
        }
    }

}
