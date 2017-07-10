//
//  FoodItemVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FoodItemsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var ref = Database.database().reference()
    var foodCat = [String:String]()
    var foodNames : [String]?{
        didSet{
            for name in foodNames!{
                ref.child("FoodItems").child(name).observe(DataEventType.value, with: { (snap) in
                    print("{{{",snap)
                    let fooditem = FoodItem(dictionary: (snap.value) as! NSDictionary)
                    self.foodItems.append(fooditem)
                })
            }
        }
        
    }
    var foodItems = [FoodItem](){
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = foodCat["name"]
//        ref = Database.database().reference()
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        collectionView?.collectionViewLayout = layout
        collectionView?.backgroundColor = Utilities.getColorWithHexString("#616161")
        collectionView?.register(FoodItemCell.self, forCellWithReuseIdentifier: "foodItemCell")
        collectionView?.register(FoodItemsHeaderPic.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "foodItemsPic")
        collectionView?.reloadData()

        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodItemCell", for: indexPath) as! FoodItemCell
        cell.foodItem = foodItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 72)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let foodDetailVC =  FoodDetailsVC()
        foodDetailVC.food = foodItems[indexPath.row]
        navigationController?.pushViewController(foodDetailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "foodItemsPic", for: indexPath) as! FoodItemsHeaderPic
        let url = URL(string: foodCat["pics"]!)
        header.headerImageView.kf.setImage(with: url)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: 250)
    }
}


class FoodItemCell : UICollectionViewCell{
    
    var foodItem : FoodItem?{
        didSet{
            let url = URL(string: (foodItem?.pics)!)
            foodImage.kf.setImage(with:url)
            

            nameLabel.text = foodItem?.name
            priceLabel.text = "₦\(String(describing: (foodItem?.price)!))"
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
        label.text = "White amala and Efo soup"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "₦120"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Soft ibadan meat"
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0.5
        return label
    }()
    
    
    
    func setupViews(){
        
        addSubview(foodImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(descriptionLabel)
        
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 6).isActive = true
        nameLabel.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        priceLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        
    }
    
}

class FoodItemsHeaderPic: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let headerImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"images-30")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupViews(){
        addSubview(headerImageView)
        
    
        headerImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
