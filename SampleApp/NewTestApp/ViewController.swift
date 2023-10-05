//
//  ViewController.swift
//  NewTestApp
//
//  Created by khushbu on 29/09/23.
//

import UIKit
import CasualFoundryCore

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func action_Login(_ sender: Any) {
        CfLogIdnetityBuilder().setAppUserId(app_user_id:"sdkTestUserId")
                              .setIdentifyAction(identity_action: .login)
                              .build()
    }
    
}

