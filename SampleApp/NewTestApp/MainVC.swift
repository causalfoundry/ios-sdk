//
//  Main.swift
//  NewTestApp
//
//  Created by khushbu on 26/10/23.
//

import UIKit
import CHWManagement

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_CHW_Managements_Events(_ sender: Any) {
        testCHW_ManagementEvents()
        
    }
    
    
    func testCHW_ManagementEvents () {
        CfLogChwModuleEventBuilder().setChwModuleEvent(.assessment)
                                    .updateImmediately(true)
                                    .build()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
