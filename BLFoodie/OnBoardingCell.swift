//
//  OnBoardingCell.swift
//  Foodie
//
//  Created by Zone 3 on 6/26/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class OnBoardingCell : UICollectionViewCell {
    
    var page : OnBoardingPage?{
        didSet{
            guard let page = page else {
                return
            }
            pageImageView.image = UIImage(named: page.imgName)
            
            let attributedText = NSMutableAttributedString(string: page.message, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName : Utilities.getColorWithHexString("#ff00ff")])
            pageMessageTextView.attributedText = attributedText
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.characters.count))
            
            
        }
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor =  Utilities.getColorWithHexString("#414648") //Utilities.getColorWithHexString("#ff00ff")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pageImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 130
        iv.backgroundColor = .red
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let pageMessageTextView : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = false
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.numberOfLines = 3
        tv.textColor = Utilities.getColorWithHexString("#ff00ff")
        return tv
    }()
    
    func setupViews(){
        addSubview(pageMessageTextView)
        addSubview(pageImageView)
        
        
        pageImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pageImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageImageView.widthAnchor.constraint(equalToConstant: 260).isActive = true
        pageImageView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        
        pageMessageTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageMessageTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageMessageTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        pageMessageTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        
        
    }
}

struct OnBoardingPage {
    var imgName: String
    var message: String
}

