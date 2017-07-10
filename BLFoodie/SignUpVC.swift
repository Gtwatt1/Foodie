//
//  SignUpVC.swift
//  Foodie
//
//  Created by Zone 3 on 6/16/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import Toaster
import Firebase
import FirebaseDatabase


// Signup

class SignUpVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    let imagePicker = UIImagePickerController()
    var ref: DatabaseReference!
    var scrollView : UIScrollView!
    var container : UIView!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Utilities.getColorWithHexString("#616161")
        container = UIView(frame: view.frame)
        container.backgroundColor = Utilities.getColorWithHexString("#616161")

        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = Utilities.getColorWithHexString("#616161")
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 64)
        scrollView.autoresizingMask = .flexibleHeight
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        setupViews()

    }
    
    func keyboardShow(){
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 260)

    
    }
    
    
    func keyboardHide(){
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 36)

    
    }
    var registrationBundle = [String : Any]()

    
    lazy var profileImage : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 60
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loadImageGallery)))
        return iv
    }()
    
    lazy var firstNameTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.layer.borderWidth = 0.8
        tv.layer.cornerRadius = 8
        tv.backgroundColor = Utilities.getColorWithHexString("#616161")
        tv.layer.borderColor = Utilities.getColorWithHexString("f06292").cgColor
        tv.textAlignment = .center
        tv.textColor = Utilities.getColorWithHexString("f06292")
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.attributedPlaceholder = NSAttributedString(string: "First name",
                            attributes: [NSForegroundColorAttributeName: Utilities.getColorWithHexString("#f06292"), NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
    lazy var lastNameTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        let centeredParagraphStyle = NSMutableParagraphStyle()
        tv.layer.borderColor = Utilities.getColorWithHexString("f06292").cgColor
        centeredParagraphStyle.alignment = .center
        tv.textAlignment = .center
        tv.layer.borderWidth = 0.8
        tv.layer.cornerRadius = 8
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = Utilities.getColorWithHexString("f06292")
        tv.backgroundColor = Utilities.getColorWithHexString("#616161")
        tv.attributedPlaceholder = NSAttributedString(string: "Last name",
                                attributes: [NSForegroundColorAttributeName: Utilities.getColorWithHexString("#f06292"), NSFontAttributeName : UIFont.systemFont(ofSize: 13), NSParagraphStyleAttributeName: centeredParagraphStyle])
        return tv
    }()
    
    lazy var emailTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.layer.borderColor = Utilities.getColorWithHexString("f06292").cgColor
        tv.textAlignment = .center
        tv.layer.borderWidth = 0.8
        tv.layer.cornerRadius = 8
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = Utilities.getColorWithHexString("f06292")
        tv.backgroundColor = Utilities.getColorWithHexString("#616161")
        tv.attributedPlaceholder = NSAttributedString(string: "Email",
                                attributes: [NSForegroundColorAttributeName: Utilities.getColorWithHexString("#f06292"), NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
    
    lazy var passwordTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.textAlignment = .center
        tv.isSecureTextEntry = true
        tv.layer.borderWidth = 0.8
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.layer.cornerRadius = 8
        tv.textColor = Utilities.getColorWithHexString("f06292")
        tv.backgroundColor = Utilities.getColorWithHexString("#616161")
        tv.layer.borderColor = Utilities.getColorWithHexString("#f06292").cgColor
        tv.attributedPlaceholder = NSAttributedString(string: "Password",  attributes: [NSForegroundColorAttributeName: Utilities.getColorWithHexString("#f06292"), NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
    
    lazy var confirmPasswordTV : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.borderStyle = UITextBorderStyle.roundedRect
        tv.textAlignment = .center
        tv.layer.borderWidth = 0.8
        tv.layer.cornerRadius = 8
        tv.textColor = Utilities.getColorWithHexString("f06292")
        tv.backgroundColor = Utilities.getColorWithHexString("#616161")
        tv.layer.borderColor = Utilities.getColorWithHexString("f06292").cgColor
        tv.isSecureTextEntry = true
        tv.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSForegroundColorAttributeName: Utilities.getColorWithHexString("#f06292"), NSFontAttributeName : UIFont.systemFont(ofSize: 13)])
        return tv
    }()
    
//    lazy var dobTV : UITextView = {
//        let tv = UITextView()
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.delegate = self
//        tv.textColor = .lightGray
//        tv.text = "Date of Birth"
//        tv.inputView = self.datePicker
//        return tv
//    }()
//    
//    lazy var genderTV : UITextView = {
//        let tv = UITextView()
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.delegate = self
//        tv.textColor = .lightGray
//        tv.text = "Select Gender"
//        tv.inputView = self.genderPicker
//        return tv
//    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitleColor(Utilities.getColorWithHexString("#616161"), for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    let leftDividerLine : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.7, alpha: 1)
        return line
    }()
    
    let rightDividerLine : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.7, alpha: 1)
        return line
    }()
    
    let orLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "or"
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    let completeReg : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Complete Registration With"
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    let orLabel2 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "or"
        label.textColor = .white
        return label
    }()
    
    lazy var alreadyAccountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an Account? Log in"
        label.textColor = Utilities.getColorWithHexString("#f06292")
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startSignin)))
        return label
    }()
    
//    let googleImageButton : GIDSignInButton = {
//        let button = GIDSignInButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 10
//        button.backgroundColor = .white
//        return button
//    }()
//    
//    let facebookImageButton : FBSDKLoginButton = {
//        let button = FBSDKLoginButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 10
//        button.layer.masksToBounds = true
//        button.backgroundColor = .orange
//        button.layer.cornerRadius = 10
//        button.readPermissions = ["email", "public"]
//        return button
//    }()
    var currentText : String?
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            currentText = textView.text
            textView.text = nil
            textView.textColor = .black
        }
        
        //
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = currentText
            
        }
    }
    
    func startSignin(){
    
    
    }
    
    func handleSignup(){
        
        guard let lastName = lastNameTV.text, let firstName = firstNameTV.text, let email = emailTV.text, let _pass = passwordTV.text,let _cPass = confirmPasswordTV.text else{ return}
        
        if firstName.isEmpty{
            Toast(text: "Wrong First Name").show()
            return
        }
        if lastName.isEmpty {
            Toast(text: "Wrong Last name").show()
            return
        }
        if email.isEmpty {
            Toast(text: "Wrong Email").show()
            return
        }
        if _cPass.isEmpty || _pass.isEmpty ||  _cPass != _pass {
            Toast(text: "Password Dont match").show()
            return
        
        }
        
        Auth.auth().createUser(withEmail: email, password: _cPass) { (user, error) in
            if error == nil{
                Toast(text: "Sign Up successful").show()
                FoodieUserDefaults().setloggedIn(status: true)
                let nwUserObject = User(name: firstName + " " + lastName, address: "", email: email)
                let nwUser = ["name": firstName + " " + lastName, "address": "", "email": email]
                FoodieUserDefaults.cacheUserAcctDetails(accountObj: nwUserObject.toJsonString())
                self.ref.child("Users").child((user?.uid)!).setValue(nwUser)
                
//                UINavigationController(rootViewController: <#T##UIViewController#>)
                self.navigationController?.pushViewController(UserVC(), animated: true)
            }else{
                print(error?.localizedDescription ?? "Error In Signing")
            }
        }
        
        registrationBundle[Constants.fullName] = "\(String(describing: firstName)) \(String(describing: lastName))"
        registrationBundle[Constants.lastName] = lastName
        registrationBundle[Constants.firstName] = firstName
        registrationBundle[Constants.email] = email
        
        registrationBundle[Constants.picture] = profileImagePath
        print(registrationBundle)
        
    }
    
    var profileImagePath : URL?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imageName         = imageUrl.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = NSURL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        profileImagePath = localPath
        
        
        if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            profileImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func loadImageGallery(){
        print("help")
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }


    
    
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)

        container.addSubview(profileImage)
        container.addSubview(firstNameTV)
        container.addSubview(lastNameTV)
        container.addSubview(emailTV)
        container.addSubview(passwordTV)
        container.addSubview(confirmPasswordTV)
        container.addSubview(signUpButton)
        container.addSubview(orLabel1)
        container.addSubview(leftDividerLine)
        container.addSubview(rightDividerLine)
        container.addSubview(completeReg)
        container.addSubview(orLabel2)
//        view.addSubview(googleImageButton)
//        view.addSubview(facebookImageButton)
        
        
        profileImage.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 48).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        firstNameTV.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        firstNameTV.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        firstNameTV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstNameTV.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant : 24).isActive = true
        
        
        lastNameTV.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        lastNameTV.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        lastNameTV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lastNameTV.topAnchor.constraint(equalTo: firstNameTV.bottomAnchor, constant : 16).isActive = true
        
        emailTV.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        emailTV.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        emailTV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTV.topAnchor.constraint(equalTo: lastNameTV.bottomAnchor, constant : 16).isActive = true
        
        passwordTV.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        passwordTV.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        passwordTV.heightAnchor.constraint(equalToConstant: 48).isActive = true
        passwordTV.topAnchor.constraint(equalTo: emailTV.bottomAnchor, constant : 16).isActive = true
        
        confirmPasswordTV.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        confirmPasswordTV.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        confirmPasswordTV.heightAnchor.constraint(equalToConstant: 48).isActive = true
        confirmPasswordTV.topAnchor.constraint(equalTo: passwordTV.bottomAnchor, constant : 16).isActive = true
        
        signUpButton.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 24).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -24).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        signUpButton.topAnchor.constraint(equalTo: confirmPasswordTV.bottomAnchor, constant : 16).isActive = true
        
        orLabel1.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        orLabel1.widthAnchor.constraint(equalToConstant: 20).isActive = true
        orLabel1.heightAnchor.constraint(equalToConstant: 15).isActive = true
        orLabel1.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant : 16).isActive = true
        
        leftDividerLine.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        leftDividerLine.rightAnchor.constraint(equalTo: orLabel1.leftAnchor,constant : -4).isActive = true
        leftDividerLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        leftDividerLine.centerYAnchor.constraint(equalTo: orLabel1.centerYAnchor).isActive = true
        
        rightDividerLine.leftAnchor.constraint(equalTo: orLabel1.rightAnchor).isActive = true
        rightDividerLine.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
        rightDividerLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        rightDividerLine.centerYAnchor.constraint(equalTo: orLabel1.centerYAnchor).isActive = true
        
        completeReg.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        completeReg.topAnchor.constraint(equalTo: orLabel1.bottomAnchor, constant : 24).isActive = true
        completeReg.heightAnchor.constraint(equalToConstant: 24).isActive = true
        completeReg.widthAnchor.constraint(equalToConstant: 210).isActive = true
        
        orLabel2.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        orLabel2.topAnchor.constraint(equalTo: completeReg.bottomAnchor, constant: 36).isActive = true
        orLabel2.widthAnchor.constraint(equalToConstant: 20).isActive = true
        orLabel2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
//        googleImageButton.widthAnchor.constraint(equalToConstant : 148).isActive = true
//        googleImageButton.rightAnchor.constraint(equalTo: orLabel2.leftAnchor,constant : -4).isActive = true
//        googleImageButton.heightAnchor.constraint(equalToConstant: 72).isActive = true
//        googleImageButton.centerYAnchor.constraint(equalTo: orLabel2.centerYAnchor).isActive = true
//        
//        facebookImageButton.leftAnchor.constraint(equalTo: orLabel2.rightAnchor,constant : 4).isActive = true
//        facebookImageButton.widthAnchor.constraint(equalToConstant : 148).isActive = true
//        facebookImageButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        facebookImageButton.centerYAnchor.constraint(equalTo: orLabel2.centerYAnchor).isActive = true
//        
    }



}
