//
//  CartVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import Firebase
import Toaster


class CartVC : UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var ref  : DatabaseReference!
    override func viewWillAppear(_ animated: Bool) {
//        collectionView?.reloadData()
//        cart = [Order](json:FoodieUserDefaults().getCart().reduce("", +))
    }
    
    var cart = [Order]()
    var cartID = [String]()
        
    override func viewDidLoad() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        collectionView?.collectionViewLayout = layout
        navigationItem.title = "Cart"
        collectionView?.backgroundColor = Utilities.getColorWithHexString("#616161")
        collectionView?.register(CartCell.self, forCellWithReuseIdentifier: "cartcell")
        collectionView?.register(Footer.self, forCellWithReuseIdentifier: "footercell")
//        let json = FoodieUserDefaults().getCart().reduce("", +)
//        cart = [Order](json:json)
        ref = Database.database().reference()
        
        guard let currentUserID = Auth.auth().currentUser?.uid else{
            Toast.init(text: " Please sign in to set favorite").show()
            
            return
        }
        ref.child("Users").child(currentUserID).child("Cart").observe(.value, with: { (snapshot) in
            for item in snapshot.children{
                if let dictValue = (item as! DataSnapshot).value as? NSDictionary{
                    let cartItem = Order(food: FoodItem(dictionary: dictValue["foodItem"]  as! NSDictionary), quan: dictValue["quantity"] as! Int)
                    self.cart.append(cartItem)
                    self.cartID.append( (item as! DataSnapshot).key)
                    self.collectionView?.reloadData()
                }
            
            }
        })
        


//        collectionView?.register(Footer.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footercell")
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != cart.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartcell", for: indexPath) as! CartCell
            cell.order = cart[indexPath.row]
            cell.cartId = cartID[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "footercell", for: indexPath) as! Footer
            cell.cart = cart
            cell.orderFlag = 1
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 124)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cart.count > 0{
            return cart.count + 1
        }else{
            return cart.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == cart.count{
            navigationController?.pushViewController(MapView(), animated: true)
        }
    }
    

}


class CartCell : UICollectionViewCell{
    var ref : DatabaseReference!
    var cartId = String()
    let currentUserID = Auth.auth().currentUser?.uid
    
    var order : Order?{
        didSet{
            priceLabel.text = "₦\(Int((order?.foodItem?.price)!)! * (order?.quantity)!)"
            nameLabel.text = order?.foodItem?.name
            quantityLabel.text = "\((order?.quantity)!)"
        }
    
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        ref = Database.database().reference()
        setupViews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    lazy var deleteImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(white: 0.8, alpha: 0.8) //Utilities.getColorWithHexString("#616161")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteItem)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "₦1200"
        label.textColor = .green
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Semo and Efo riro"
        label.textAlignment = .left
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderDetails : UILabel = {
        let label = UILabel()
        label.text = "No Extra"
        label.textAlignment = .left
        label.textColor =  UIColor(white: 0.8, alpha: 0.8) //Utilities.getColorWithHexString("#616161")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textAlignment = .center
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let increaseImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(white: 0.8, alpha: 0.8) //Utilities.getColorWithHexString("#616161")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let decreaseImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "minus")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(white: 0.8, alpha: 0.8) //Utilities.getColorWithHexString("#616161")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let divider : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Utilities.getColorWithHexString("#616161")
        return v
    }()
    
    let container : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Utilities.getColorWithHexString("#414648")
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()

    
    func deleteItem(){
        ref.child("Users").child(currentUserID!).child("Cart").child(cartId).setValue(nil)
    }
    
    
    
    func setupViews(){
    
        addSubview(container)
        addSubview(deleteImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(orderDetails)
        addSubview(quantityLabel)
        addSubview(increaseImage)
        addSubview(decreaseImage)
        addSubview(divider)

        
        
        
        container.topAnchor.constraint(equalTo: topAnchor, constant : 8).isActive  = true
        container.leftAnchor.constraint(equalTo: leftAnchor, constant : 16).isActive  = true
        container.rightAnchor.constraint(equalTo: rightAnchor , constant : -16).isActive  = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive  = true
        
        
        nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant : 8).isActive  = true
        nameLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant : 8).isActive  = true
        nameLabel.rightAnchor.constraint(equalTo: container.rightAnchor , constant : 64).isActive  = true
        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor ).isActive  = true
        priceLabel.widthAnchor.constraint(equalToConstant: 64).isActive  = true
        priceLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8).isActive  = true
        priceLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        orderDetails.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive  = true
        orderDetails.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive  = true
        orderDetails.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive  = true
        orderDetails.heightAnchor.constraint(equalToConstant: 12).isActive  = true
        
        
        divider.bottomAnchor.constraint(equalTo: increaseImage.topAnchor, constant: -8).isActive  = true
        divider.rightAnchor.constraint(equalTo: container.rightAnchor).isActive  = true
        divider.leftAnchor.constraint(equalTo: container.leftAnchor).isActive  = true
        divider.heightAnchor.constraint(equalToConstant: 1.5).isActive  = true
        
        increaseImage.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor, constant : 4).isActive  = true
        increaseImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive  = true
        increaseImage.widthAnchor.constraint(equalToConstant: 20).isActive  = true
        increaseImage.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
        quantityLabel.leftAnchor.constraint(equalTo: decreaseImage.rightAnchor, constant: 4).isActive  = true
        quantityLabel.bottomAnchor.constraint(equalTo: decreaseImage.bottomAnchor).isActive  = true
        quantityLabel.widthAnchor.constraint(equalToConstant: 30).isActive  = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
        decreaseImage.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive  = true
        decreaseImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive  = true
        decreaseImage.widthAnchor.constraint(equalToConstant: 20).isActive  = true
        decreaseImage.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
        
        deleteImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16).isActive  = true
        deleteImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive  = true
        deleteImage.widthAnchor.constraint(equalToConstant: 20).isActive  = true
        deleteImage.heightAnchor.constraint(equalToConstant: 20).isActive  = true
    
    }
    
}


class Footer : UICollectionViewCell{
    var cart = [Order]()

    var orderFlag : Int?{
        didSet{
            let prices = cart.map({ (order)  in
                Int((order.foodItem?.price)!)! * order.quantity
            })
            totalPriceValue.text = "\(prices.reduce(0,+))"
            quantityValue.text = "\(cart.count)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        backgroundColor = Utilities.getColorWithHexString("#616161")
        
//        cart = [Order](json:FoodieUserDefaults().getCart().reduce("", +))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let confirmOrder : UIButton = {
        let b = UIButton()
        b.setTitle("Confirm Order", for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .green
        b.setTitleColor(Utilities.getColorWithHexString("#616161"), for: .normal)
        b.layer.cornerRadius = 12
        b.layer.masksToBounds = true
        return b
    }()
    
    let totalPrice : UILabel = {
        let label = UILabel()
        label.text = "Total Price:  "
        label.textAlignment = .right
        label.textColor = Utilities.getColorWithHexString("#ff00ff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalPriceValue : UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textAlignment = .left
        label.textColor = Utilities.getColorWithHexString("#ff00ff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.text = "Order Quantity:  "
        label.textAlignment = .right
        label.textColor = Utilities.getColorWithHexString("#ff00ff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityValue : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = Utilities.getColorWithHexString("#ff00ff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
    
        addSubview(totalPrice)
        addSubview(quantityLabel)
        addSubview(quantityValue)
        addSubview(totalPriceValue)
        addSubview(confirmOrder)
        
        confirmOrder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        confirmOrder.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        confirmOrder.widthAnchor.constraint(equalToConstant: 160).isActive = true
        confirmOrder.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        totalPrice.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive  = true
        totalPrice.widthAnchor.constraint(equalToConstant: 128).isActive  = true
        totalPrice.rightAnchor.constraint(equalTo: totalPriceValue.leftAnchor, constant: -2).isActive  = true
        totalPrice.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        quantityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive  = true
        quantityLabel.widthAnchor.constraint(equalToConstant: 128).isActive  = true
        quantityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive  = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        
        totalPriceValue.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive  = true
        totalPriceValue.widthAnchor.constraint(equalToConstant: 64).isActive  = true
        totalPriceValue.topAnchor.constraint(equalTo: totalPrice.topAnchor).isActive  = true
        totalPriceValue.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        quantityValue.topAnchor.constraint(equalTo: quantityLabel.topAnchor).isActive  = true
        quantityValue.widthAnchor.constraint(equalToConstant: 64).isActive  = true
        quantityValue.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor, constant: 2).isActive  = true
        quantityValue.heightAnchor.constraint(equalToConstant: 24).isActive  = true
    
    }
    
//    func handleConfirm(){
//        let MapVc = MapView()
//        
//        navigationController?.pushViewController(MapVc, animated: true)
//        
//    }
    
}
