//
//  OnboardingVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/26/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class OnBoardingVC : UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    
    let onBoardingCell = "onboardingcell"
    
    var onBoardingPages : [OnBoardingPage] = {
        let firstPage = OnBoardingPage(imgName: "images-30", message: "Shopping for food has never been easier with our friendly App")
        let secondPage = OnBoardingPage(imgName: "soyabeansmilk", message: "Shopping for food has never been easier with our friendly App")
        let thirdPage = OnBoardingPage(imgName: "coconutcandy", message: "Shopping for food has never been easier with our friendly App")
        let fourthPage = OnBoardingPage(imgName: "JollofRice", message: "Shopping for food has never been easier with our friendly App")
        
        return [firstPage,secondPage, thirdPage, fourthPage]
    }()
    
    let getStartedButton : UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(Utilities.getColorWithHexString("#FF00FF"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = Utilities.getColorWithHexString("#FF00FF").cgColor
        button.layer.cornerRadius = 12
        button.setImage(UIImage(named:"spoon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = Utilities.getColorWithHexString("#FF00FF")
        button.addTarget(self, action: #selector(getStartedSetupScreen), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 200, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0)
        return button
    }()
    
    
    func getStartedSetupScreen() {
        let setupScreen = HomeVC()
        present(setupScreen, animated: true, completion: nil)
    }
    
    
    lazy var pageControl : UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPageIndicatorTintColor = Utilities.getColorWithHexString("#FF00FF")
        control.pageIndicatorTintColor = .lightGray
        control.numberOfPages = self.onBoardingPages.count
        control.transform = CGAffineTransform(scaleX: 2, y: 2)
        return control
    }()
    
    let bottomContainer : UIView = {
        let view = UIView()
        view.backgroundColor = Utilities.getColorWithHexString("#414648")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var onBoardingCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = Utilities.getColorWithHexString("#414648") //UIColor(red: 158, green: 183, blue: 183, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.backgroundColor = .red
        
        return collectionView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "FOODIES"
        label.backgroundColor = Utilities.getColorWithHexString("#414648")
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment  = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Utilities.getColorWithHexString("#ff00ff")
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Utilities.getColorWithHexString("#414648")
        onBoardingCollectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: onBoardingCell)
        navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    
    func setupViews(){
        view.addSubview(onBoardingCollectionView)
        view.addSubview(pageControl)
        view.addSubview(bottomContainer)
        view.addSubview(getStartedButton)
        view.addSubview(nameLabel)
        
        
        
        
        bottomContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true

        
        pageControl.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor).isActive = true
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant : 30).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        onBoardingCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        onBoardingCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        onBoardingCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        onBoardingCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor).isActive = true
        //        onBoardingCollectionView.heightAnchor.constraint(equalToConstant: 500)
//        onBoardingCollectionView.backgroundColor = .purple
        
        
        getStartedButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        getStartedButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        getStartedButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onBoardingCell, for: indexPath) as! OnBoardingCell
        cell.page = onBoardingPages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height-224)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pageControl.currentPage = Int(targetContentOffset.pointee.x/view.frame.width)
    }
}
