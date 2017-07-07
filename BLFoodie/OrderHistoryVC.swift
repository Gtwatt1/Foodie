//
//  OrderHistory.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class OrderHistoryVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        navigationItem.title = "Order History"

        collectionView?.backgroundColor = Utilities.getColorWithHexString("#616161") 
        collectionView?.register(OrderHistoryCell.self, forCellWithReuseIdentifier: "orderCell")
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}


class OrderHistoryCell : UICollectionViewCell{
    
    var order : Order?{
        didSet{
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = Utilities.getColorWithHexString("#414648")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let orderStatus : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.text = Status.inTransit.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()

    let foodItems : UITextView = {
        let tv = UITextView()
        tv.text = "Name     price"
        tv.layer.cornerRadius = 6
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let buyAgain : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBuy), for: .touchUpInside)
        button.backgroundColor = .green
        button.setTitle("Buy Again", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
        
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.text = "30th of June 2016"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "₦120"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()
    
    
    func handleBuy(){
    
    
    
    }
    func setupViews(){
        
        addSubview(orderStatus)
        addSubview(dateLabel)
        addSubview(priceLabel)
        addSubview(buyAgain)
        addSubview(foodItems)
        
        orderStatus.widthAnchor.constraint(equalToConstant: 60).isActive = true
        orderStatus.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        orderStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        orderStatus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        foodItems.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8).isActive  = true
        foodItems.leftAnchor.constraint(equalTo: leftAnchor, constant : 16).isActive  = true
        foodItems.widthAnchor.constraint(equalTo: widthAnchor, multiplier :0.6).isActive  = true
        foodItems.heightAnchor.constraint(equalToConstant: 48).isActive  = true
        
        buyAgain.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive  = true
        buyAgain.rightAnchor.constraint(equalTo: rightAnchor, constant : -8).isActive  = true
        buyAgain.widthAnchor.constraint(equalToConstant: 90).isActive  = true
        buyAgain.heightAnchor.constraint(equalToConstant: 36).isActive  = true
        
    }
    
}
