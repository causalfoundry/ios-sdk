//
//  CFViewController.swift
//
//
//  Created by Causal Foundry on 30.11.23.
//

import UIKit

open class CFViewController: UIViewController {
    private var className: String {
        NSStringFromClass(classForCoder).components(separatedBy: ".").last!
    }

    private var path: String {
        return "\(Bundle.main.bundleIdentifier ?? "")/\(className)"
    }

    private var renderBeginTime: CFAbsoluteTime!
    private var renderEndTime: CFAbsoluteTime!
    private var durationBeginTime: CFAbsoluteTime!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        renderBeginTime = CFAbsoluteTimeGetCurrent()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        durationBeginTime = CFAbsoluteTimeGetCurrent()
        if renderEndTime == nil {
            // only set once. user can return to preview view in stack
            renderEndTime = CFAbsoluteTimeGetCurrent()
        }
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CfLogPageBuilder()
            .setContentBlock(content_block: CoreConstants.shared.contentBlock)
            .setTitle(title: className)
            .setPath(path: path)
            .setDuration(duration: Float(CFAbsoluteTimeGetCurrent() - durationBeginTime))
            .setRenderTime(render_time: Int(renderEndTime - renderBeginTime))
            .build()
    }
}
