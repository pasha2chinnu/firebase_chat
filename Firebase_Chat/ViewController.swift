//
//  ViewController.swift
//  Firebase_Chat
//
//  Created by kvanadev5 on 23/03/17.
//  Copyright © 2017 kvanadev5. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style:.plain, target:self, action:#selector(handleLogout))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleLogout(){
        
        let loginpage = LoginController()
        present(loginpage, animated: true, completion: nil)
    }

}

