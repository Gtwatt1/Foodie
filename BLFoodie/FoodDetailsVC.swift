//
//  FoodDetailsVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Toaster
import Firebase

var ORDERS = [String](){
    didSet{
        FoodieUserDefaults().setOrder(order: ORDERS)
    }
}

var FAVORITES =  [String](){
    didSet{
        FoodieUserDefaults().setFav(fav: FAVORITES)
    }
}

var CART =  [String](){
    didSet{
        FoodieUserDefaults().setCart(cart: CART)
    }
}

class FoodDetailsVC : UIViewController {

    var food : FoodItem?{
        didSet{
            
            makeFavoriteIV.image = isFavoriteFood() ? UIImage(named: "fav") : UIImage(named: "fav_filled")
            navigationItem.title = food?.name
            let url = URL(string: (food?.pics)!)
            foodPic.kf.setImage(with:url)
            foodName.text = food?.name
            priceLabel.text = "₦\(String(describing: (food?.price)!))"
            foodDescription.text = food?.foodDescription
        }
    }
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        navigationItem.title = "Food Details"
        view.backgroundColor = Utilities.getColorWithHexString("#414648")
        setupViews()
//        navigationController?.navigationBar.isHidden = true
    }
    
    
    let foodPic : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "images-30")
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var makeFavoriteIV : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "fav")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFav)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let foodName : UILabel = {
        let label = UILabel()
        label.text = "Fufu and Vegetable Soup"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "₦1200"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .green//Utilities.getColorWithHexString("#ffooff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let foodDescriptionLabel : UILabel = {
        let label = UILabel()
        label.text = " Food Description"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Utilities.getColorWithHexString("#ffooff")
        return v
    }()
    
    let foodDescription : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = false
        tv.backgroundColor = .clear
        tv.textColor = .white
        return tv
    }()
    
    let orderButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOrder), for: .touchUpInside)
        button.backgroundColor = Utilities.getColorWithHexString("#ffooff")
        button.setTitleColor(Utilities.getColorWithHexString("#414648"), for: .normal)
        button.setTitle("Place Order", for: .normal)
        return button
    
    }()
    
    let customizeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Utilities.getColorWithHexString("#414648"), for: .normal)
        button.addTarget(self, action: #selector(handleCustomize), for: .touchUpInside)
        button.backgroundColor = .green
        button.setTitle("Add Extra", for: .normal)
        return button
        
    }()
    
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = Utilities.getColorWithHexString("#414648")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var increaseImage : UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = Utilities.getColorWithHexString("#ffooff")
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInc)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var decreaseImage : UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "minus")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = Utilities.getColorWithHexString("#ffooff")
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDec)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let foodQuantityLabel : UILabel = {
        let label = UILabel()
        label.text = " Quantity"
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var orderSet : Bool = false
    var key : String!

    
    func handleOrder(){
        
        if !orderSet{
            //    CART.append(Order(food: food!,quan: Int(quantityLabel.text!)!).toJsonString() )
            orderButton.backgroundColor = Utilities.getColorWithHexString("#414648")
            Toast.init(text: "\(String(describing: quantityLabel.text!)) \(foodName.text!)(s) Added to Cart").show()
        }else{
            //    CART.dropLast()
            orderButton.backgroundColor = Utilities.getColorWithHexString("#ffooff")
            Toast.init(text: "\(String(describing: quantityLabel.text!)) \(foodName.text!)(s) removed from Cart").show()
        }
        
        guard let currentUserID = Auth.auth().currentUser?.uid else{
            return
        }

        if !orderSet{
            key = ref.child("Users").child(currentUserID).child("Cart").childByAutoId().key
            ref.child("Users").child(currentUserID).child("Cart").child(key).setValue(Order(food: food!,quan: Int(quantityLabel.text!)!).toDictionary())
//            CART.append(Order(food: food!,quan: Int(quantityLabel.text!)!).toJsonString() )
            
        }else{
            ref.child("Users").child(currentUserID).child("Cart").child(key).setValue(nil)
//            CART.dropLast()
            

        }
        orderSet = !orderSet
    }
    
    func handleCustomize(){
    
    
    }
    
    var favSet : Bool = false
    func handleFav(){
        
        makeFavoriteIV.image = favSet ? UIImage(named: "fav") : UIImage(named: "fav_filled")
        favSet = !favSet
        
        guard let currentUserID = Auth.auth().currentUser?.uid else{
            Toast.init(text: " Please sign in to set favorite").show()

            return
        }
        
        if favSet {
            key = ref.child("Users").child(currentUserID).child("Fav").childByAutoId().key
            ref.child("Users").child(currentUserID).child("Fav").child(key).setValue(food?.toDictionary())
//             FAVORITES.append(food!.toJsonString())
             Toast.init(text: " \(String(describing: foodName.text!))(s) Added to Favorites").show()
        }else{
            ref.child("Users").child(currentUserID).child("Fav").child(key).setValue(nil)
//             FAVORITES.dropLast()
             Toast.init(text: " \(foodName.text!)(s) removed from Favorites").show()
        }
    }
    
    var orderQuantity = Int()
    func handleInc(){
        if !orderSet{
            orderQuantity = Int(quantityLabel.text!)!
            quantityLabel.text = String(orderQuantity + 1)
        }else{
            Toast.init(text: "Order set already, add in Cart").show()
            
        }
    }
    
    func handleDec(){
        if !orderSet{
            orderQuantity = Int(quantityLabel.text!)!
            if orderQuantity == 1 {return}
            quantityLabel.text = String(orderQuantity - 1)
        }else{
            Toast.init(text: "Order set already, add in Cart").show()

        }
    }
    
    func setupViews(){
    
        view.addSubview(foodPic)
        view.addSubview(foodName)
        view.addSubview(foodDescription)
        view.addSubview(orderButton)
        view.addSubview(customizeButton)
        view.addSubview(priceLabel)
        view.addSubview(foodDescriptionLabel)
        view.addSubview(divider)
        view.addSubview(makeFavoriteIV)
        view.addSubview(quantityLabel)
        view.addSubview(increaseImage)
        view.addSubview(decreaseImage)
        view.addSubview(foodQuantityLabel)
        


        
        foodPic.topAnchor.constraint(equalTo: view.topAnchor, constant : 64).isActive  = true
        foodPic.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        foodPic.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        foodPic.heightAnchor.constraint(equalToConstant: 200).isActive  = true
        
        foodName.topAnchor.constraint(equalTo: foodPic.bottomAnchor, constant : 8).isActive  = true
        foodName.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        foodName.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        foodName.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        priceLabel.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 8).isActive  = true
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive  = true
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive  = true
        priceLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        makeFavoriteIV.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive  = true
        makeFavoriteIV.widthAnchor.constraint(equalToConstant: 24).isActive  = true
        makeFavoriteIV.leftAnchor.constraint(equalTo: view.leftAnchor, constant:48).isActive  = true
        makeFavoriteIV.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        foodDescriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,  constant: 2).isActive  = true
        foodDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        foodDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        foodDescriptionLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        
        divider.topAnchor.constraint(equalTo: foodDescriptionLabel.bottomAnchor).isActive  = true
        divider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        divider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/2).isActive  = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive  = true
        
        foodDescription.topAnchor.constraint(equalTo: foodDescriptionLabel.bottomAnchor,  constant: 2).isActive  = true
        foodDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive  = true
        foodDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive  = true
        foodDescription.heightAnchor.constraint(equalToConstant: 150).isActive  = true
        
        
        orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49).isActive  = true
        orderButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/2).isActive  = true
        orderButton.heightAnchor.constraint(equalToConstant: 56).isActive  = true
        
        customizeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49).isActive  = true
        customizeButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        customizeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/2).isActive  = true
        customizeButton.heightAnchor.constraint(equalToConstant: 56).isActive  = true
        
        increaseImage.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor, constant : 4).isActive  = true
        increaseImage.bottomAnchor.constraint(equalTo: decreaseImage.bottomAnchor).isActive  = true
        increaseImage.widthAnchor.constraint(equalToConstant: 28).isActive  = true
        increaseImage.heightAnchor.constraint(equalToConstant: 28).isActive  = true
        
        quantityLabel.leftAnchor.constraint(equalTo: decreaseImage.rightAnchor, constant: 4).isActive  = true
        quantityLabel.centerYAnchor.constraint(equalTo: decreaseImage.centerYAnchor).isActive  = true
        quantityLabel.widthAnchor.constraint(equalToConstant: 20).isActive  = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
        decreaseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40).isActive  = true
        decreaseImage.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -4).isActive  = true
        decreaseImage.widthAnchor.constraint(equalToConstant: 28).isActive  = true
        decreaseImage.heightAnchor.constraint(equalToConstant: 28).isActive  = true
        
        
        foodQuantityLabel.bottomAnchor.constraint(equalTo: decreaseImage.topAnchor,  constant: -2).isActive  = true
        foodQuantityLabel.centerXAnchor.constraint(equalTo: quantityLabel.centerXAnchor).isActive  = true
        foodQuantityLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        foodQuantityLabel.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
    }

    
    func isFavoriteFood() -> Bool{
        // download all favorites then check if current food is in favorite
        return true
    }
    
    
    
    
    
}
