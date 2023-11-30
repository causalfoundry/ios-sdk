//
//  CFViewController.swift
//  
//
//  Created by Causal Foundry on 30.11.23.
//

import UIKit

open class CFViewController: UIViewController {
    
    private var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    private var path:String {
        return "\(Bundle.main.bundleIdentifier ?? "")/\(self.className)"
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CfLogPageBuilder()
            .setContentBlock(content_block: CoreConstants.shared.contentBlock)
            .setTitle(title: self.className)
            .setPath(path: self.path)
            .setDuration(duration: 30)
            .setRenderTime(render_time: 300)
            .build()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
