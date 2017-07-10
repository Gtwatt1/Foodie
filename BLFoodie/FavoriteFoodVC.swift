//
//  FavoriteFoodVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import Firebase
import Toaster


class FavoriteFoodVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var ref : DatabaseReference!
    
    var favFoods = [FoodItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorite Food"
        
        collectionView?.backgroundColor =  Utilities.getColorWithHexString("#616161")
        collectionView?.register(FavoriteFoodCell.self, forCellWithReuseIdentifier: "favoriteCell")
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 0
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView?.collectionViewLayout = layout
        ref = Database.database().reference()
        
        
        guard let currentUserID = Auth.auth().currentUser?.uid else{
            Toast.init(text: " Please sign in to set favorite").show()
            
            return
        }
        ref.child("Users").child(currentUserID).child("Fav").observe(.value, with: { (snapshot) in
            
            for item in snapshot.children{
                let food = FoodItem(dictionary: (item as! DataSnapshot).value as! NSDictionary)
                self.favFoods.append(food)
                self.collectionView?.reloadData()
            }
        })
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteFoodCell
        cell.food = favFoods[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favFoods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 10 , height: 168)
    }
    
}



class FavoriteFoodCell : UICollectionViewCell{
    
    var food : FoodItem?{
        didSet{
            let url = URL(string: (food?.pics)!)
            foodImage.kf.setImage(with:url)
            nameLabel.text = food?.name
            categoryLabel.text = food?.foodDescription
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Utilities.getColorWithHexString("#414648")

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 18
        iv.image = UIImage(named: "images-30")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.text = "Eba and white stew "
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Africian dish"
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let buyAgain : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBuy), for: .touchUpInside)
        button.backgroundColor = .green
        button.setTitleColor(Utilities.getColorWithHexString("#414648"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("Buy", for: .normal)
        button.layer.cornerRadius = 6
        return button
        
    }()
    
    func handleBuy(){
    
    
    }
    
    
    func setupViews(){
        
        addSubview(foodImage)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(buyAgain)
        addSubview(buyAgain)
        
        
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        foodImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        nameLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 4).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        categoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        buyAgain.bottomAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 0).isActive  = true
        buyAgain.rightAnchor.constraint(equalTo: rightAnchor, constant : -4).isActive  = true
        buyAgain.widthAnchor.constraint(equalToConstant: 40).isActive  = true
        buyAgain.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
    }
    
}
