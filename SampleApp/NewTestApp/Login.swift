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
        CfLogIdnetityBuilder().setAppUserId(app_user_id:"sdkTestUserId")
            .setIdentifyAction(identity_action: .register)
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
    
    
    @IBAction func action_Media(_ sender: Any) {
        let mediaDetail = MediaCatalogModel(name: "TestVideo", description: "Testing video player", length: "6.8", resolution: "50", language: "Afar")
        CfLogMediaEventBuilder()
            .setMediaId(media_id: "374784738")
            .setMediaType(media_type: MediaType.video) //Required - MediaType
            .setMediaModel(mediaModelValue: mediaDetail)
            .setMediaAction(media_action: MediaAction.pause) // Required - MediaAction
            .setCurrentDuration(duration: 1234556) // Required - Int
            .setContentBlock(content_block: ContentBlock.core) // Optional - ContentBlock > default is core
            .build()
    }
    
    @IBAction func rateAction(_ sender: Any) {
        CfLogRateEventBuilder()
            .setContentBlock(contentBlock: ContentBlock.e_commerce)
            .setRateValue(rateValue: 4.5) //Required -  Float 0 to 5
            .setRateType(type: RateType.order) //Required -  RateType
           .setSubjectId(subjectId: "testOrderId") //Required -  String
            .build()
    }
    
    
    
    
    func testCoreEvents() {
        
        let resultItems: [SearchItemModel] = [
            SearchItemModel(item_id:"item ID 2" , item_type: SearchItemType.patientRecord.rawValue, facility_id: "112123"),
            SearchItemModel(item_id:"item ID 2" , item_type: SearchItemType.patientRecord.rawValue, facility_id: "112123")
            
        ]

    
        let filtersDictionaryData: [String: String] = ["FirstName": "Hello", "LastName": "World"]

        
        
        
        CfLogSearchEventBuilder().setContentBlock(contentBlock: .chw_mgmt)
            .setSearchModule(searchModule: .screening)
            .setQuery(query:"Test Query")
            .setResultItemsList(resultsList: resultItems)
            .setFilter(filter: filtersDictionaryData)
            .setIsNewSearch(isNewSearch: true)
            .setPage(page: 1)
            .build()
            

        
    }
}

