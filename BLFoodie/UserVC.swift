//
//  UserVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/23/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit


class UserVC: UIViewController {
    
    
    override func viewDidLoad() {
        view.backgroundColor = Utilities.getColorWithHexString("#414648")
        navigationItem.title = "Profile"
        let navbar = UIBarButtonItem(image: UIImage(named:"edit"), style: .plain, target: self, action: #selector(handleProfileEdit))
        navigationItem.rightBarButtonItem = navbar
        navigationController?.navigationBar.isHidden = false
        navigationItem.setHidesBackButton(true, animated: false)

//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupViews()
    }
    
    let profilePic : UIImageView = {
        let iv = UIImageView()
//        iv.backgroundColor = .white
        iv.image = UIImage(named: "avatar")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.text = "no 5 Aaron irabor, Agungi, Lekki, Nigeria"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameContainer : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .white
        return v
    }()
    
    let emailContainer : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .white
        return v
    }()
    
    let addressContainer : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .white
        return v
    }()
    
    let bannerPic : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "italian")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
//
//    let emailPic : UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = UIImage(named: "name")
//        return iv
//    }()
//
//    
//    let addressPic : UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = UIImage(named: "name")
//        return iv
//    }()

    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Senator Ibiyemi Adelabi"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.text = " Adelabiwhite@home.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(white: 0.8, alpha: 0.8)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderLabel : UILabel = {
        let label = UILabel()
        label.text = "Orders"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .green
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderDescription : UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteLabel : UILabel = {
        let label = UILabel()
        label.text = " Favorites"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteDescription : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = Utilities.getColorWithHexString("#ffooff")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteContainer : UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.borderColor = Utilities.getColorWithHexString("#ffooff").cgColor
        v.backgroundColor  = Utilities.getColorWithHexString("#414648")
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavorite)))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var orderContainer : UIView = {
        let v = UIView()
        v.backgroundColor = Utilities.getColorWithHexString("#414648")
        v.isUserInteractionEnabled = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.green.cgColor
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOrder)))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    func handleOrder(){
        let vc = OrderHistoryVC(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func handleFavorite(){
        let vc = FavoriteFoodVC(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleProfileEdit(){
    
    
    }
    
    func setupViews(){
        
        view.addSubview(profilePic)
        view.addSubview(nameContainer)
        view.addSubview(emailContainer)
        view.addSubview(addressContainer)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(addressLabel)
        view.addSubview(orderContainer)
        view.addSubview(orderLabel)
        view.addSubview(orderDescription)
        view.addSubview(favoriteContainer)
        view.addSubview(favoriteLabel)
        view.addSubview(favoriteDescription)
        view.addSubview(bannerPic)
//        view.addSubview(emailPic)
//        view.addSubview(addressPic)

        
        profilePic.topAnchor.constraint(equalTo: view.topAnchor,constant : 80).isActive  = true
        profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        profilePic.widthAnchor.constraint(equalToConstant: 120).isActive  = true
        profilePic.heightAnchor.constraint(equalToConstant: 120).isActive  = true
        
//        addressLabel.centerYAnchor.constraint(equalTo: addressContainer.centerYAnchor).isActive  = true
//        addressLabel.leftAnchor.constraint(equalTo: addressContainer.leftAnchor, constant: 8).isActive  = true
//        addressLabel.rightAnchor.constraint(equalTo: addressContainer.rightAnchor).isActive  = true
//        addressLabel.heightAnchor.constraint(equalToConstant: 48).isActive  = true
        
        nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant : 8).isActive  = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive  = true
        
        bannerPic.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant : -40).isActive  = true
        bannerPic.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        bannerPic.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        bannerPic.heightAnchor.constraint(equalToConstant: 72).isActive  = true
        
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant : 4).isActive  = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        emailLabel.heightAnchor.constraint(equalToConstant: 16).isActive  = true
        
//        emailPic.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor).isActive  = true
//        emailPic.widthAnchor.constraint(equalToConstant: 24).isActive  = true
//        emailPic.leftAnchor.constraint(equalTo: emailContainer.leftAnchor, constant:12).isActive  = true
//        emailPic.heightAnchor.constraint(equalToConstant: 20).isActive  = true
        
        addressLabel.topAnchor.constraint(equalTo: orderContainer.bottomAnchor, constant : 20).isActive  = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive  = true
        addressLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive  = true
        addressLabel.heightAnchor.constraint(equalToConstant: 48).isActive  = true
        
//        addressPic.centerYAnchor.constraint(equalTo: addressContainer.centerYAnchor).isActive  = true
//        addressPic.widthAnchor.constraint(equalToConstant: 24).isActive  = true
//        addressPic.leftAnchor.constraint(equalTo: addressContainer.leftAnchor, constant:12).isActive  = true
//        addressPic.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        
//        nameLabel.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor).isActive  = true
//        nameLabel.leftAnchor.constraint(equalTo: nameContainer.leftAnchor, constant: 8).isActive  = true
//        nameLabel.rightAnchor.constraint(equalTo: nameContainer.rightAnchor).isActive  = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true
//        
//        emailLabel.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor).isActive  = true
//        emailLabel.leftAnchor.constraint(equalTo: emailContainer.leftAnchor, constant: 8).isActive  = true
//        emailLabel.rightAnchor.constraint(equalTo: emailContainer.rightAnchor).isActive  = true
//        emailLabel.heightAnchor.constraint(equalToConstant: 24).isActive  = true

//        
        
        orderContainer.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24).isActive  = true
        orderContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive  = true
        orderContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/2, constant: -24).isActive  = true
        orderContainer.heightAnchor.constraint(equalToConstant: 64).isActive  = true
        
        orderLabel.bottomAnchor.constraint(equalTo: orderContainer.bottomAnchor, constant: -12).isActive  = true
        orderLabel.centerXAnchor.constraint(equalTo: orderContainer.centerXAnchor).isActive  = true
        orderLabel.widthAnchor.constraint(equalTo: orderContainer.widthAnchor).isActive  = true
        orderLabel.heightAnchor.constraint(equalToConstant: 16).isActive  = true
        
        orderDescription.bottomAnchor.constraint(equalTo: orderLabel.topAnchor, constant: -2).isActive  = true
        orderDescription.centerXAnchor.constraint(equalTo: orderContainer.centerXAnchor).isActive  = true
        orderDescription.widthAnchor.constraint(equalTo: orderContainer.widthAnchor).isActive  = true
        orderDescription.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
        favoriteContainer.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24).isActive  = true
        favoriteContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive  = true
        favoriteContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/2, constant: -24).isActive  = true
        favoriteContainer.heightAnchor.constraint(equalToConstant: 64).isActive  = true
        
        
        favoriteLabel.bottomAnchor.constraint(equalTo: favoriteContainer.bottomAnchor, constant: -12).isActive  = true
        favoriteLabel.centerXAnchor.constraint(equalTo: favoriteContainer.centerXAnchor).isActive  = true
        favoriteLabel.widthAnchor.constraint(equalTo: favoriteContainer.widthAnchor).isActive  = true
        favoriteLabel.heightAnchor.constraint(equalToConstant: 16).isActive  = true
        
        favoriteDescription.bottomAnchor.constraint(equalTo: favoriteLabel.topAnchor, constant: -2).isActive  = true
        favoriteDescription.centerXAnchor.constraint(equalTo: favoriteContainer.centerXAnchor).isActive  = true
        favoriteDescription.widthAnchor.constraint(equalTo: favoriteContainer.widthAnchor).isActive  = true
        favoriteDescription.heightAnchor.constraint(equalToConstant: 24).isActive  = true
        
    }
    

}

