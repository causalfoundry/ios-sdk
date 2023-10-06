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
    var duration:Float?
    var render_time:Int?
    var meta:Any?
    
    init(path: String? = nil, title: String? = nil, duration: Float? = nil, render_time: Int? = nil, meta: Any? = nil) {
        self.path = path
        self.title = title
        self.duration = duration
        self.render_time = render_time
        self.meta = meta
    }
}
