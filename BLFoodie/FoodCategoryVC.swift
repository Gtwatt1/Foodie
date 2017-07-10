//
//  FoodCategoryVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/17/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher



class FoodCategoryVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    var foodCategories = [FoodCategory](){
        didSet{
            
        }
    }
    var banners = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        ref.child("FoodCategory").observe(.value, with: { (dataSnap) in
            for itemSnapShot in dataSnap.children {
                let cat =  FoodCategory(dictionary: (itemSnapShot as! DataSnapshot).value as! NSDictionary)
                self.foodCategories.append(cat)
                self.collectionView?.reloadData()
            }
            
        })
    }
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        navigationItem.title = "Foodies"
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 4, right: 8)
        collectionView?.collectionViewLayout = layout
        collectionView?.backgroundColor = Utilities.getColorWithHexString("#616161")
        collectionView?.register(FoodCatCell.self, forCellWithReuseIdentifier: "mycell")
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headercell")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! FoodCatCell
        cell.foodCat = foodCategories[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 10 , height: 164)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headercell", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let foodItemsVC = FoodItemsVC(collectionViewLayout : layout)
        let foods = foodCategories[indexPath.row].foods
        foodItemsVC.foodNames = foods
        foodItemsVC.foodCat = ["name" : foodCategories[indexPath.row].name,
                               "pics" : foodCategories[indexPath.row].pics
                                ]
        navigationController?.pushViewController(foodItemsVC, animated: true)
        
    }

}



class FoodCatCell : UICollectionViewCell{
    
    var foodCat : FoodCategory?{
        didSet{
            let url = URL(string: (foodCat?.pics)!)
            self.foodImage.kf.setImage(with:url)

            self.nameLabel.text = foodCat?.name ?? ""
            self.descriptionLabel.text = foodCat?.catDescription
        }
            
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = Utilities.getColorWithHexString("#414648")
        layer.cornerRadius = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodImage : UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.image = UIImage(named: "images-30")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Vegetables"
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.alpha = 0.7
        label.textAlignment = .center
        label.backgroundColor = .black
        return label
    }()
    
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Enjoy Your Morning with well sauced meat and vegetables"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .green
        label.alpha = 0.5
        return label
    }()
    
    
    
    
    func setupViews(){
        
        addSubview(foodImage)
        addSubview(nameLabel)
        addSubview(descriptionLabel)

        
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        foodImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: foodImage.leftAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: foodImage.bottomAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: foodImage.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: foodImage.leftAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant : 4).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: foodImage.rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
}


class Header : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var banners = [String]()
    var ref: DatabaseReference!

    override init(frame: CGRect) {
        super.init(frame: frame)
        ref = Database.database().reference()

        ref.child("Banners").observe(.value, with: { (snapshot) in
            print(snapshot)
            for itemSnapShot in snapshot.children {
                let item = (itemSnapShot as! DataSnapshot).value
                self.banners.append(item as! String)
                self.appsColletionView.reloadData()
            }
        })

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appsColletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(BannerCell.self, forCellWithReuseIdentifier: "appcell")
        return collection
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appcell", for: indexPath) as! BannerCell
        let url = URL(string:  banners[indexPath.row])
        let image = UIImage(named: "images-30")
        cell.appImage.kf.setImage(with:url, placeholder: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: frame.height - 12)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    func setupViews(){
        addSubview(appsColletionView)
        appsColletionView.delegate = self
        appsColletionView.dataSource = self
        
        
        appsColletionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        appsColletionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        appsColletionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        appsColletionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    private class BannerCell : UICollectionViewCell{
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var appImage : UIImageView = {
            let iv = UIImageView()
            iv.layer.cornerRadius = 18
            iv.contentMode = .scaleAspectFill
            iv.layer.masksToBounds = true
            iv.backgroundColor = .darkGray
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
         func setupViews() {
            addSubview(appImage)
            appImage.layer.cornerRadius = 0
            appImage.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
            appImage.layer.borderWidth = 1
            appImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            appImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            appImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            appImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
        }
    }

}
