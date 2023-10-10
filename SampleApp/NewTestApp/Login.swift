//
//  ViewController.swift
//  NewTestApp
//
//  Created by khushbu on 29/09/23.
//

import UIKit
import CasualFoundryCore

class Login: UIViewController {
    
    
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
    
    @IBAction func actionRegister(_ sender: Any) {
        var mediaDetail = MediaCatalogModel(
        CfLogMediaEventBuilder()
            .setMediaId(media_id: "374784738")
            .setMediaType(media_type: MediaType.video) //Required - MediaType
            .setMediaAction(media_action: MediaAction.pause) // Required - MediaAction
            .setCurrentDuration(duration: 1234556) // Required - Int
            .setContentBlock(content_block: ContentBlock.core) // Optional - ContentBlock > default is core
            .build()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
   
    @IBAction func action_Logout(_ sender: Any) {
        CfLogIdnetityBuilder().setAppUserId(app_user_id:"sdkTestUserId")
                              .setIdentifyAction(identity_action: .logout)
                              .build()
    }
}

