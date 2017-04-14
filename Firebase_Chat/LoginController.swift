//
//  LoginController.swift
//  Firebase_Chat
//
//  Created by kvanadev5 on 23/03/17.
//  Copyright © 2017 kvanadev5. All rights reserved.
//

import UIKit
import Firebase

//constructor
extension UIColor{
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}


class LoginController: UIViewController {
    
    var inputConstraintHeight: NSLayoutConstraint?
    var nameTextConstraintHeight: NSLayoutConstraint?
    var emailTextConstraintHeight: NSLayoutConstraint?
    var passwordTextConstraintHeight: NSLayoutConstraint?

    
    //inputsContainerView
    let inputsContainerView: UIView={
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    let segment: UISegmentedControl={
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginSegment), for: UIControlEvents.valueChanged)
        return sc
    }()
    
    //register button
    let registerButton: UIButton={
        let button = UIButton()
        button.backgroundColor = UIColor.init(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleRegister), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    func handleLoginSegment(){
        let title = segment.titleForSegment(at: segment.selectedSegmentIndex)
        segment.setTitle(title, forSegmentAt: segment.selectedSegmentIndex)
        inputConstraintHeight?.constant = segment.selectedSegmentIndex == 0 ? 100 : 150
        nameTextConstraintHeight?.isActive = false
        nameTextConstraintHeight = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: segment.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextConstraintHeight?.isActive = true
    }
    
    
    func handleRegister(){
        let error = NSError()
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else {
                print("form is not valid")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error)
            }
            
            guard let uid = user?.uid else{
                return
            }
            // successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://fir-chat-afc9f.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email":email]
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if error != nil{
                    print(error)
                    return
                }
                print("User saved successfully")
            })

        })
    }
    
    //register button
    let nameTextField: UITextField={
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView={
        let view = UIView()
        view.backgroundColor = UIColor.init(r: 61, g: 91, b: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField={
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView={
        let view = UIView()
        view.backgroundColor = UIColor.init(r: 61, g: 91, b: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let passwordTextField: UITextField={
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let profileImageView: UIImageView={
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pasha")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(r: 61, g: 91, b: 155)
        self.view.addSubview(inputsContainerView)
        self.view.addSubview(registerButton)
        self.view.addSubview(segment)
//        self.view.addSubview(profileImageView)
        
        setupInputsContainerView()
        setupLoginRegisterbutton()
        loginSegmentControl()
//        setUpProfileImageView()
    }

 //for whaite status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loginSegmentControl(){
        segment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segment.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        segment.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setupInputsContainerView(){
        //need x, y, width, height
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputConstraintHeight = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputConstraintHeight?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)

        
        //need x, y, width, height
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextConstraintHeight = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            nameTextConstraintHeight?.isActive = true
        

        //need x, y, width, height
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextConstraintHeight = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextConstraintHeight?.isActive = true
        
        //need x, y, width, height
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y, width, height
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextConstraintHeight = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextConstraintHeight?.isActive = true

    }
    
    func setupLoginRegisterbutton(){
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func setUpProfileImageView(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.contentMode = UIViewContentMode.scaleAspectFit

    }

}
