//
//  SIgnInVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/16/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class SignInVC : UIViewController{

    lazy var emailTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.textAlignment = .center
        tv.attributedPlaceholder = NSAttributedString(string: "Email",
            attributes: [NSForegroundColorAttributeName: UIColor.purple, NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
    
    lazy var passwordTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.textAlignment = .center
        tv.attributedPlaceholder = NSAttributedString(string: "Email",  attributes: [NSForegroundColorAttributeName: UIColor.purple, NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
    
    override func viewDidLoad() {
        
    }

}
