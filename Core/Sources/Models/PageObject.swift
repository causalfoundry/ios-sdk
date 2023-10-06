//
//  File.swift
//  
//
//  Created by khushbu on 06/10/23.
//

import Foundation


struct PageObject {
    var path:String?
    var title:String?
    var duration:String?
    var render_time:String?
    var meta:String?
    
    init(path: String? = nil, title: String? = nil, duration: String? = nil, render_time: String? = nil, meta: String? = nil) {
        self.path = path
        self.title = title
        self.duration = duration
        self.render_time = render_time
        self.meta = meta
    }
}
