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
    
    private var renderBeginTime: CFAbsoluteTime!
    private var renderEndTime: CFAbsoluteTime!
    private var durationBeginTime: CFAbsoluteTime!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        renderBeginTime = CFAbsoluteTimeGetCurrent()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        durationBeginTime = CFAbsoluteTimeGetCurrent()
        if renderEndTime != nil {
            // only set once. user can return to preview view in stack
            renderEndTime = CFAbsoluteTimeGetCurrent()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CfLogPageBuilder()
            .setContentBlock(content_block: CoreConstants.shared.contentBlock)
            .setTitle(title: self.className)
            .setPath(path: self.path)
            .setDuration(duration: Float(CFAbsoluteTimeGetCurrent() - durationBeginTime))
            .setRenderTime(render_time: Int(renderEndTime - renderBeginTime))
            .build()
    }
}
